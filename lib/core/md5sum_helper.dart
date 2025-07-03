import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart' as crypto;
import 'package:flutter/foundation.dart';

///Read [length] (or first 1024) from file and return md5sum
///[length]==null - file read without restrictions
class Md5sumHelper {
  Future<String?> calculateMD5SumAsyncWithCrypto(String filePath, [int? lenght = 1024]) async {
    var ret = '';
    var file = File(filePath);
    if (await file.exists() == false) {
      debugPrint('`$filePath` does not exits so unable to evaluate its MD5 sum.');
      return null;
    }
    try {
      var hash = await crypto.md5.bind(lenght == null ? file.openRead() : file.openRead().take(lenght)).first;
      ret = base64.encode(hash.bytes);
    } catch (exception) {
      debugPrint('Unable to evaluate the MD5 sum :$exception');
      return null;
    }
    return ret;
  }
}
