import 'package:animated_tree_view/tree_view/tree_node.dart';
import 'package:clear_app_helper/core/domain/entities/settings_enum.dart';
import 'package:clear_app_helper/core/i18n/core_i18n.dart';
import 'package:clear_app_helper/core/presentation/bloc/curent_entity/curent_entity_bloc_bloc.dart';
import 'package:clear_app_helper/core/presentation/functions.dart';
import 'package:clear_app_helper/core/presentation/widgets/loading_indicator.dart';
import 'package:clear_app_helper/core/presentation/widgets/my_scaffold_list_widget.dart';
import 'package:clear_app_helper/core/presentation/widgets/my_scaffold_tree_widget.dart';
import 'package:clear_app_helper/core/presentation/widgets/settings_builder_widget.dart';
import 'package:clear_app_helper/core/presentation/widgets/view_default_case_widget.dart';
import 'package:clear_app_helper/core/settings_route_names.dart';
import 'package:clear_app_helper/settings/domain/entities/search/settings_search_entity.dart';
import 'package:clear_app_helper/settings/domain/entities/settings_entity.dart';
import 'package:clear_app_helper/settings/presentation/bloc/settings_bloc_bloc.dart';
import 'package:clear_app_helper/settings/presentation/widgets/settings_card_widget.dart';
import 'package:clear_app_helper/settings/presentation/widgets/settings_list_search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class SettingsViewPage extends StatelessWidget {
  final Widget drawer;
  const SettingsViewPage({required this.drawer, super.key});

  @override
  Widget build(BuildContext context) {
    const emptySearchEntity = SettingsSearchEntity();
    final argSearchEntity = FunctionsHelper.getArgs<SettingsSearchEntity>() ?? emptySearchEntity;

    context.read<SettingsBloc>().add(SettingsBlocEvent.load(argSearchEntity));
    return SettingsBuilderWidget(
      childFunc: (sf) {
        final listSearchWidget = SettingsListSearchWidget(searchEntity: sf.se);
        final bloc = context.read<SettingsBloc>();
        const onTapRouteName = SettingsRouteNames.settingsDetailPage;
        final appBarTitle = GetIt.instance<CoreI18n>().settings;
        onLongPress(int id) => FunctionsHelper.setNextSettingsVariantById(id: id);

        bloc.setItemActions(null); //не самый лучших способ установки, можно забыть...
        resetSearch() => bloc.add(const SettingsBlocEvent.load(SettingsSearchEntity()));
        return BlocBuilder<CurentEntityBloc, CurentEntityBlocState>(
          builder: (context, state) => switch (state) {
            EmptyCurentEntityBlocState() => Builder(
              builder: (context) {
                context.read<CurentEntityBloc>().add(
                  CurentEntityBlocEvent.setNewCurents(curentBloc: context.read<SettingsBloc>()),
                );
                return loadingIndicator(GetIt.instance<CoreI18n>().curentEntityLoading);
              },
            ),
            LoadedCurentEntityBlocState() => Builder(
              builder: (context) {
                if (state.curentBloc is! SettingsBloc) {
                  context.read<CurentEntityBloc>().add(
                    CurentEntityBlocEvent.setNewCurents(curentBloc: context.read<SettingsBloc>()),
                  );
                }
                return ViewDefaultCaseWidget(
                  viewStyle: sf.se.viewStyle,
                  viewDefaultSettings: SettingsSettingsEnum.viewDefault,
                  listWidget: MyScaffoldListWidget<SettingsEntity>(
                    addButton: false,
                    appBarTitle: appBarTitle,
                    onTapRouteName: onTapRouteName,
                    curentIdsList: sf.list,
                    curentSearchEntity: sf.se,
                    emptySearchEntity: emptySearchEntity,
                    listSearchWidget: listSearchWidget,
                    cardWidget: (id, _) => SettingsCardWidget(id: id),
                    drawer: drawer,
                    onLongPress: onLongPress,
                    resetSearch: resetSearch,
                    controller: sf.controller,
                  ),
                  treeWidget: FutureBuilder(
                    future: context.read<SettingsBloc>().getList(sf.se),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData && snapshot.data == null) return const SizedBox();

                      final TreeNode<int?> tree = TreeNode<int?>.root();

                      for (final SettingsEntity item in snapshot.data!) {
                        ///for example "global.logging.size.limit"
                        final nameList = item.name.split('.');
                        final rootChild = TreeNode<int?>(key: nameList[0], parent: tree.root);
                        if (!tree.root.childrenAsList.contains(rootChild)) {
                          tree.add(rootChild); //"global"
                        }
                        for (int index = 1; index < nameList.length - 1; index++) {
                          final parentPath = nameList.sublist(0, index).join('.');
                          final node = TreeNode<int?>(key: nameList[index], parent: tree.elementAt(parentPath));

                          if (!tree.elementAt(parentPath).childrenAsList.contains(node)) {
                            tree.elementAt(parentPath).add(node); // first "logging", next "size"
                          }
                        }
                        final parent = nameList.sublist(0, nameList.length - 1).join('.'); //"size"
                        final finalNode = TreeNode<int?>(
                          key: nameList.last,
                          parent: tree.elementAt(parent),
                          data: item.id,
                        );
                        tree.elementAt(parent).add(finalNode); //"limit"
                      }
                      return MyScaffoldTreeWidget<SettingsEntity>(
                        onTapRouteName: SettingsRouteNames.settingsDetailPage,
                        curentTree: tree,
                        curentSearchEntity: sf.se,
                        appBarTitle: appBarTitle,
                        listSearchWidget: listSearchWidget,
                        drawer: drawer,
                        emptySearchEntity: emptySearchEntity,
                        cardWidget: (id, _) => SettingsCardWidget(id: id),
                        onLongPress: onLongPress,
                        resetSearch: resetSearch,
                      );
                    },
                  ),
                  graphWidget: null,
                );
              },
            ),
          },
        );
      },
    );
  }
}
