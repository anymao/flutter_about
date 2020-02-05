import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_about/contants/api_contants.dart';
import 'package:flutter_about/model/beans.dart';
import 'package:flutter_about/resource/strings.dart';
import 'package:flutter_about/utils/logger.dart';

import 'net/http.dart';

class WelfarePicsProvider {
  static const int pageSize = 30;
  final Dio _dio = gankDio;
  final CancelToken _cancelToken = CancelToken();

  Future<List<WelfarePic>> loadPicsByPage(int page) async {
    try {
      final response = await _dio.get(ApiConstants.getWelfarePictures(page),
          cancelToken: _cancelToken);
      logger.d(response);
      if (response.statusCode == HttpStatus.ok) {
        final map = response.data;
        final bool error = map['error'];
        if (!error) {
          final results = map['results'];
          final list = List<WelfarePic>();
          results.forEach((v) {
            list.add(WelfarePic.fromJson(v));
          });
          return list;
        } else {
          return Future.error("服务器返回错误!");
        }
      } else {
        return Future.error(Strings.networkError);
      }
    } catch (e) {
      logger.e(e);
      return Future.error(Strings.networkError);
    }
  }
}
