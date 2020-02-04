import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class ImageHelper {
  ImageHelper._();

  static const String imageFolder = "assets/images/";

  static String getImagePath(String name, {String format: 'png'}) {
    return '$imageFolder$name.$format';
  }

  static Image fromAssets(String name,
      {String path = imageFolder,
      double width = 32,
      double height = 32,
      BoxFit fit = BoxFit.cover}) {
    return Image.asset(
      "$path$name",
      width: width,
      height: height,
      fit: fit,
    );
  }

  static Widget loadImage(String name,
      {double width = 120, double height = 120}) {
    return Container(
      width: width,
      height: height,
      decoration:
          BoxDecoration(image: DecorationImage(image: AssetImage(name))),
    );
  }

  static ImageProvider imageProvider(dynamic imageResource, {double scale}) {
    if (imageResource is String) {
      return NetworkImage(imageResource, scale: scale);
    } else if (imageResource is Uint8List) {
      return MemoryImage(imageResource, scale: scale);
    } else if (imageResource is File) {
      return FileImage(imageResource, scale: scale);
    } else {
      throw Exception(
          "Sorry! the imageResource Type:<${imageResource.runtimeType}> is not support");
    }
  }
}
