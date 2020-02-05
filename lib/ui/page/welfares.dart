import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_about/model/beans.dart';
import 'package:flutter_about/repository/welfare_pics_provider.dart';
import 'package:flutter_about/ui/widget/welfare_picture.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

///福利页面
class WelfarePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            SystemNavigator.pop();
          },
        ),
        title: Text("妹子"),
      ),
      body: _WelfarePicList(),
    );
  }
}

class _WelfarePicList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _WelfarePicListState();
  }
}

class _WelfarePicListState extends State<_WelfarePicList> {
  WelfarePicsProvider _provider;
  List<WelfarePic> _list = List();
  RefreshController _controller;
  int _currentPage = 0;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    _controller = RefreshController(initialRefresh: true);
    _provider = WelfarePicsProvider();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshConfiguration.copyAncestor(
        context: context,
        child: SmartRefresher(
          controller: _controller,
          enablePullDown: true,
          enablePullUp: true,
          onRefresh: () {
            _provider.loadPicsByPage(1).then((v) {
              _currentPage = 1;
              _list.clear();
              _list.addAll(v);
              _controller.refreshCompleted();
              setState(() {});
            }).catchError((e) {
              _controller.refreshFailed();
            });
          },
          onLoading: () {
            _provider.loadPicsByPage(_currentPage + 1).then((v) {
              _currentPage++;
              _list.addAll(v);
              _controller.loadComplete();
              setState(() {});
            }).catchError((e) {
              _controller.loadFailed();
            });
          },
          child: GridView.builder(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (context, index) => _buildItem(context, _list[index]),
            itemCount: _list.length,
          ),
        ));
  }

  Widget _buildItem(BuildContext context, WelfarePic pic) {
    return WelfarePicture(pic);
  }
}
