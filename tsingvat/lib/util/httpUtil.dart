import 'package:dio/dio.dart';
import 'package:tsingvat/util/Interceptors.dart';
import 'dart:async';

class HttpUtil {
  Dio _client;
  static final HttpUtil _instance = HttpUtil._internal();

  factory HttpUtil() => _instance;

  HttpUtil._internal() {
    if (_client == null) {
      BaseOptions options = new BaseOptions();
      options.baseUrl = 'http://121.199.66.17:8800';
      //'http://192.168.1.7:8089'; //"http://www.wanandroid.com";
      //'http://10.0.2.2:8089';
      //options.contentType = "Headers.formUrlEncodedContentType";
      options.receiveTimeout = 1000 * 10; //10秒
      options.connectTimeout = 2000; //5秒
      _client = new Dio(options);
      _client.interceptors.add(CustomInterceptors());
    }
  }

  Future<Map<String, dynamic>> get(url, params) async {
    Response response;
    try {
      response = await _client.get(url, queryParameters: params);
    } on DioError catch (e) {
      return Future.error(e);
    }

    // if (response.data is DioError) {
    //   return resultError(response.data['code']);
    // }
    print(response);
    return response.data;
  }

  Future<Map<String, dynamic>> delete(url, params) async {
    Response response;
    try {
      response = await _client.delete(url, queryParameters: params);
    } on DioError catch (e) {
      return Future.error(e);
    }

    // if (response.data is DioError) {
    //   return resultError(response.data['code']);
    // }
    print(response);
    return response.data;
  }

  Future<Map<String, dynamic>> post(url, data) async {
    Response response;
    try {
      response = await _client.post(url, data: data);
    } on DioError catch (e) {
      print(e);
      return Future.error(e);
    }
    print(response);
    return response.data;
  }

  Future<Map<String, dynamic>> put(url, data) async {
    Response response;
    try {
      response = await _client.put(url, data: data);
    } on DioError catch (e) {
      print(e);
      return Future.error(e);
    }
    print(response);
    return response.data;
  }
}
