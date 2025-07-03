import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Widget loadingIndicator(String text, [double? height]) {
  if (kDebugMode) log("loading indicator: $text");
  return SizedBox(
    height: height,
    child: const Center(child: CircularProgressIndicator()),
  );
}
