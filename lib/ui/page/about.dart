import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_about/resource/app_colors.dart';
import 'package:flutter_about/utils/images_utils.dart';

import '../../main.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            SystemNavigator.pop();
          },
        ),
        title: Text("关于"),
      ),
      body: _createBody(),
    );
  }

  Widget _createBody() {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: double.infinity),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 10,
              height: 72,
            ),
            ImageHelper.fromAssets(
              "lvxiaomao.jpg",
              width: 72,
              height: 85,
              fit: BoxFit.cover,
            ),
            SizedBox(
              width: 10,
              height: 72,
            ),
            Text(
              mPackageInfo?.appName,
              style: TextStyle(
                color: AppColors.colorText2,
                fontSize: 18,
              ),
            ),
            SizedBox(
              width: 10,
              height: 72,
            ),
            Text(mPackageInfo?.version,
                style: TextStyle(
                  color: AppColors.colorText2,
                  fontSize: 18,
                ))
          ],
        ),
      ),
    );
  }
}
