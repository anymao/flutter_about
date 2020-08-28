import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_about/contants/api_contants.dart';
import 'package:flutter_about/resource/app_colors.dart';
import 'package:flutter_about/resource/strings.dart';
import 'package:flutter_about/utils/images_utils.dart';
import 'package:url_launcher/url_launcher.dart';

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
              height: 24,
            ),
            Text(
              mPackageInfo?.appName,
              style: TextStyle(
                  color: AppColors.colorText2,
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(
              width: 10,
              height: 16,
            ),
            Text("版本号:${mPackageInfo?.version}",
                style: TextStyle(
                  color: AppColors.colorText2,
                  fontSize: 18,
                )),
            SizedBox(
              width: 10,
              height: 16,
            ),
            Text("    ${Strings.readme}"),
            GestureDetector(
              child: Text(
                "Github：${ApiConstants.gitRepositoryUrl}",
                style: TextStyle(decoration: TextDecoration.underline),
              ),
              onTap: () {
                _launchUrl(ApiConstants.navigateByWanAndroid(ApiConstants.gitRepositoryUrl));
              },
            )
          ],
        ),
      ),
    );
  }

  void _launchUrl(String url) async {
    final result = await canLaunch(url);
    if (result) {
      await launch(url);
    }
  }
}
