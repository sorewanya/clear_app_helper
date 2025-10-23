Widgets, Entities and functions to create Clear App implement Clean Architecture pattern. Contain ready to use Settings

# Use
## use clear_app_helper_--DB-- package
Right now only  [clear_app_helper_isar](https://github.com/sorewanya/clear_app_helper_isar) is implement of abstract classes from this class, use it or create your own.
## GetIT package
This package use GetIt as Service Locator, add example/locator_service.dart to your project.
dont forget to add clear_app_helper_isar/example/locator_service.dart getIt.register's if use isar
## main()
see example main.dart in clear_app_helper_isar example folder

## Example
example folder contain TestEntity

# History
3.07.2025
This is package and [clear_app_helper_isar] is result of work started in 2022.
This version of this code used in 3 app.
Now I try to divisible this package, exclude isar dependency. Later I want add [clear_app_helper_sqflite].

