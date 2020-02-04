import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_about/utils/images_utils.dart';
import 'package:package_info/package_info.dart';

void main() async {
  mPackageInfo = await PackageInfo.fromPlatform();
  runApp(App());
}

PackageInfo mPackageInfo;

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: mPackageInfo?.appName ?? "WanAndroid",
      home: AboutPage(),
    );
  }


}

class AboutPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.maybePop(context);
          },
        ),
        title: Text("关于"),
      ),
      body: _createBody(),
    );
  }

  Widget _createBody() {
    return ConstrainedBox(
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
          Text(mPackageInfo?.appName),
          Text(mPackageInfo?.version)
        ],
      ),
    );
  }

}


