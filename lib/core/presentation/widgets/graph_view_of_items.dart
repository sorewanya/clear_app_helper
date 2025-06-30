import 'package:clear_app_helper/core/domain/entities/app_entity.dart';
import 'package:clear_app_helper/core/domain/entities/search_entity.dart';
import 'package:clear_app_helper/core/i18n/core_i18n.dart';
import 'package:clear_app_helper/core/presentation/widgets/my_padded_decorated_box_with_opacity.dart';
import 'package:clear_app_helper/core/presentation/widgets/text_warning.dart';
import 'package:clear_app_helper/core/route_helper.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:graphview/GraphView.dart';

/// graph widget, used [GraphView.simpleTyped]
class GraphViewOfItems<AppEntityType extends AppEntity> extends StatefulWidget {
  const GraphViewOfItems({
    super.key,
    required this.onTapRouteName,
    this.onLongPress,
    required this.cardWidget,
    required this.graph,
    this.emptySearchEntity,
  });

  /// elements to show, is being filled by graph.addEdge()
  final Graph graph;

  /// name of page [RouteHelper.toNamed]
  final String onTapRouteName;

  /// Search entity, what copyWith with selected id and send to [onTapRouteName] page
  final SearchEntity? emptySearchEntity;

  /// Long tap callback
  final Function(int itemId)? onLongPress;

  /// callback to get cartWidget for item
  final Widget Function(int itemId) cardWidget;

  @override
  State<GraphViewOfItems<AppEntityType>> createState() => _GraphViewOfItemsState<AppEntityType>();
}

class _GraphViewOfItemsState<AppEntityType extends AppEntity> extends State<GraphViewOfItems<AppEntityType>> {
  Widget rectangWidget(int? i) {
    return MyPaddedDecoratedBoxWithOpacity(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        boxShadow: const [BoxShadow(color: Colors.blue, spreadRadius: 1)],
      ),
      padding: const EdgeInsets.all(16),
      child: Text('${GetIt.instance<CoreI18n>().nodeInGraphName} $i'),
    );
  }

  @override
  Widget build(BuildContext context) {
    var curentGraph = widget.graph;

    ///Layered
    SugiyamaConfiguration builder = SugiyamaConfiguration()..bendPointShape = CurvedBendPointShape(curveLength: 20);
    builder
      ..nodeSeparation = (35)
      ..levelSeparation = (35)
      ..orientation = SugiyamaConfiguration.ORIENTATION_LEFT_RIGHT;

    return Expanded(
      child: InteractiveViewer(
        constrained: false,
        boundaryMargin: const EdgeInsets.all(300),
        minScale: 0.001,
        maxScale: 100,
        child: GraphView(
          graph: curentGraph,
          algorithm: SugiyamaAlgorithm(builder),
          paint: Paint()
            ..color = Colors.green
            ..strokeWidth = 1
            ..style = PaintingStyle.fill,
          builder: (Node node) {
            var id = node.key!.value;
            return node.key!.value != null
                ? GestureDetector(
                    onTap: (() {
                      RouteHelper.toNamed(widget.onTapRouteName, arguments: widget.emptySearchEntity?.copyWith(id: id));
                    }),
                    onLongPress: () => widget.onLongPress != null ? widget.onLongPress!(id) : {},
                    child: widget.cardWidget(id as int),
                  )
                : MyPaddedDecoratedBoxWithOpacity(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: const [BoxShadow(color: Colors.blue, spreadRadius: 1)],
                    ),
                    padding: const EdgeInsets.all(16),
                    child: TextWarning(GetIt.instance<CoreI18n>().errorGettingItemId),
                  );
          },
        ),
      ),
    );
  }
}
