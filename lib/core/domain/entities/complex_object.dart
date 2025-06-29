import 'package:clear_app_helper/core/domain/entities/app_entity.dart';

///Complex object based on <T>
///
///used for easy way to create AppEntity object with his subentities
abstract class ComplexObject<T extends AppEntity> {
  final T item;

  ComplexObject(this.item);
}
