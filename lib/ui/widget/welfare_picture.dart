import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_about/model/beans.dart';
import 'package:flutter_about/utils/images_utils.dart';

class WelfarePicture extends StatelessWidget {
  final WelfarePic _pic;

  const WelfarePicture(this._pic, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      height: 360,
      child: CachedNetworkImage(
        imageUrl: _pic.url,
        fit: BoxFit.cover,
        errorWidget: (context, url, error) {
          return ImageHelper.fromAssets("ic_not_found.jpg",
              width: 180, height: 360);
        },
      ),
    );
  }
}
