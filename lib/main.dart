import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_about/ui/page/welfares.dart';
import 'package:flutter_about/utils/logger.dart';
import 'package:package_info/package_info.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'ui/page/about.dart';

void main() async {
  mPackageInfo = await PackageInfo.fromPlatform();
  runApp(App(
    routeName: window.defaultRouteName,
  ));
}

PackageInfo mPackageInfo;

class App extends StatelessWidget {
  final String routeName;

  App({Key key, this.routeName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    logger.d("routeName is:$routeName");
    return RefreshConfiguration(
        headerBuilder: () => MaterialClassicHeader(),
        child: MaterialApp(
          title: mPackageInfo?.appName ?? "WanAndroid",
          theme: ThemeData(
            primaryColor: Color(0xFF529AFC),
            primaryColorDark: Color(0xFF529AFC),
            accentColor: Color(0xFF529AFC),
          ),
          home: AboutPage(),
          initialRoute: routeName,
          routes: routes,
        ));
  }
}

///应用页面路由
final Map<String, WidgetBuilder> routes = {
  "/about": (context) => AboutPage(),
  "/welfare": (context) => WelfarePage(),
};
