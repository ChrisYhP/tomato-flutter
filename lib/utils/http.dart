import 'package:dio/dio.dart';
import 'package:tomato/utils/config.dart';

Map<String, dynamic> optHeader = {'content-type': 'application/json'};
// or new Dio with a BaseOptions instance.
BaseOptions options = new BaseOptions(
    baseUrl: Config.baseUrl,
    connectTimeout: 5000,
    receiveTimeout: 3000,
    headers: optHeader);

Dio dio = new Dio(options);

class Http {
  static Future get(String url, Map<String, dynamic> params) async {
    var response;
    if (params != null) {
      response = await dio.get(url, queryParameters: params);
    } else {
      response = await dio.get(url);
    }
    return response.data;
  }

  static Future post(
      String url, Map<String, dynamic> params, Options options) async {
    var response = await dio.post(url, data: params, options: options);
    return response.data;
  }
}
