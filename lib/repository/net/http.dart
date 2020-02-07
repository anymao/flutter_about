import 'dart:collection';
import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter_about/contants/api_contants.dart';
import 'package:flutter_about/utils/logger.dart';

final Dio gankDio = DioManager.get(ApiConstants.gankBaseUrl);

class DioManager {
  static HashMap<String, Dio> _dioCache = HashMap();
  static bool logEnable = true;

  DioManager._();

  static Dio get(String baseUrl) {
    logger.d("调用DioManager.get($baseUrl) 准备获取Dio实例!");
    Dio dio = _dioCache[baseUrl];
    if (dio == null) {
      logger.d("$baseUrl所对应的Dio实例不存在，现在创建!");
      dio = _createWithBaseUrl(baseUrl);
      _dioCache[baseUrl] = dio;
    }
    return dio;
  }

  static Dio _createWithBaseUrl(String baseUrl) {
    final BaseOptions options = BaseOptions();
    //设置baseUrl
    options.baseUrl = baseUrl;
    //设置连接超时
    options.connectTimeout = 10000;
    //设置接收数据超时
    options.receiveTimeout = 10000;
//    if(baseUrl == ApiConstants.wanAndroidBaseUrl){
    options.contentType = "application/x-www-form-urlencoded";
//    }
    options.responseType = ResponseType.json;
    final Dio dio = Dio(options);
    //设置Cookie保存
    dio.interceptors.add(CookieManager(DefaultCookieJar()));

    dio.interceptors
        .add(DioCacheManager(CacheConfig(baseUrl: baseUrl)).interceptor);

    //http 日志日志打印
    dio.interceptors.add(LogInterceptor(
        request: true,
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true));
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
      logger.d("request:${options.toString()}");
      // Do something before request is sent
      return options; //continue
    }, onResponse: (Response response) {
      logger.d("response:${response.toString()}");
      // Do something with response data
      return response; // continue
    }, onError: (DioError e) {
      logger.e("error:${e.toString()}");
      // Do something with response error
      return e; //continue
    }));

    //https 证书校验
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) {
        return true;
      };
    };
    return dio;
  }
}
