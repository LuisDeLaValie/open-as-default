import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:uri_to_file/uri_to_file.dart';

/// OpenAsDefault is a class that helps receive files sent from an [Intent].
///
/// ```dart
/// var file = await OpenAsDefault.getFileIntent;
/// ```
///
class OpenAsDefault {
  static const MethodChannel _channel = MethodChannel('open_as_default');

  /// Get the file received from [Intent] if a file is not residing it will return null
  static Future<File?> get getFileIntent async {
    final String? path = await _channel.invokeMethod('getFileIntent');

    if (path == null || path.isEmpty) {
      return null;
    } else {
      var file = await toFile(path);

      return file;
    }
  }
}
