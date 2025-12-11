//only add int end of list, do not edit exist! or remove all db... user say 10th. mb.
enum SettingsTypeEnum {
  ///User(Default)Value as int.toString
  ///
  /// ```values = null;```
  ///
  /// 0
  integer,

  ///User(Default)Value as "true" or "false"
  ///
  /// ```values = null;```
  ///
  /// 1
  boolean,

  ///User(Default)Value as icon ```.index.toString```
  ///
  /// ```values = null;```
  ///
  /// 2
  icon,

  ///User(Default)Value as String
  ///
  /// ```values = null;```
  ///
  /// 3
  string,

  ///User(Default)Value as directory path_picker parametr
  ///
  /// ```values = null;```
  ///
  /// 4
  dirPath,

  ///User(Default)Value as file path_picker parameter
  ///
  /// ```values[0] = FileType._.name```
  ///
  ///  FileType variants: any,  media,  image,  video,  audio,  custom
  ///
  /// if use "custom" in values[0] then use values[1+] to set what file formats use
  ///
  /// ```values[1] = "jpg"; values[2] = "jpeg";```
  ///
  /// 5
  filePath,

  ///User(Default)Value as item index from values
  ///
  /// one from list of values in [List<String> values]
  ///
  /// 6
  value,

  ///User(Default)Value as list of int .split(",");
  ///
  /// example: ```userValue = "1,2,10";```
  ///
  /// 7
  listOfInt,

  ///User(Default)Value as list of index from values .split(",");
  ///
  /// ```example: userValue = "0,1,3";``` //can be sorted by user
  ///
  /// ```values=["one","two","some","qwe"...]```
  ///
  /// 8
  listOfValues,

  ///User(Default)Value as list of String .split(",");
  ///
  /// example: ```userValue = "one,two,qwe";```
  ///
  /// 9
  listOfString,

  ///User(Default)Value is empty,  values contains variants, what can be used in listOfValuesExtend
  ///
  /// ```values=["one","two","some","qwe"...]```
  ///
  /// 10
  listOfValuesBase,

  ///User(Default)Value as list of index from values .split(",");
  ///difference of [listOfValues] is values, what contains name on base setting
  ///
  /// ```example: userValue = "0,1,3";``` //can be sorted by user
  ///
  /// ```values=["core.base.settings.name"...]``` - mast be listOfValuesBase
  ///
  //TODO реши, нужно ли отдельный, когда значение должно быть выбрано только 1
  /// 11
  listOfValuesExtend,

  ///User(Default)Value is empty,  values contains json object of SearchEntity's
  ///
  /// ```values=["{Название:jsonObj}","{Название2:jsonObj}"...]```
  ///
  /// 12
  savedSearch,

  ///User(Default)Value is string contaains rfw widget code
  ///
  /// see https://pub.dev/packages/rfw
  ///
  ///13
  rfwWidget,

  ///User(Default)Value as double.toString
  ///
  /// ```values = null;```
  /// (do not fix doublee to double!)
  ///
  /// 14
  doublee,
}
