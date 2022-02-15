import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

abstract class GetImageInfo {
  static final Map<String, ui.Image> uiImageMap = {};

  static Future<ui.Image> fromFilePath(File file) async {
    return await _fromImage(Image.file(file));
  }

  static Future<ui.Image> _fromImage(Image image) {
    final completer = Completer<ui.Image>();
    image.image.resolve(const ImageConfiguration()).addListener(ImageStreamListener((info, _) {
      completer.complete(info.image);
    }));
    return completer.future;
  }

  static FutureOr<ui.Image> fromCache(File file) {
    if (uiImageMap.containsKey(file.path)) {
      return uiImageMap[file.path]!;
    } else {
      return Future(() async {
        uiImageMap[file.path] = await fromFilePath(file);
        return uiImageMap[file.path]!;
      });
    }
  }
}
