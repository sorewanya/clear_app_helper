import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter/material.dart';
import 'package:clear_app_helper/core/domain/entities/search_entity.dart';

part 'ids_finded.g.dart';

@CopyWith()
class IdsFinded<T extends SearchEntity> {
  final List<int> list;
  final T se;
  final ScrollController controller;

  IdsFinded(this.list, this.se, this.controller);
}
