import 'package:dio/dio.dart';

class CustomInterceptors extends InterceptorsWrapper {
  @override
  onRequest(RequestOptions options) {
      print("请求baseUrl：${options.baseUrl}");
      print("请求url：${options.path}");
      print('请求头: ' + options.headers.toString());
      print('请求params: ' + options.queryParameters.toString());
      if (options.data != null) {
        print('请求参数: ' + options.data.toString());
      }
    return super.onRequest(options);
  }

  @override
  onResponse(Response response) {
      if (response != null) {
        var responseStr = response.toString();
      }
    
    return super.onResponse(response); // continue
  }

  @override
  onError(DioError err) {
      print('请求异常: ' + err.toString());
      print('请求异常信息: ' + err.response?.toString() ?? "");
    return super.onError(err);
  }
}
