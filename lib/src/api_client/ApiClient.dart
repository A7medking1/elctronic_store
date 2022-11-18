import 'dart:io';

import 'package:dio/dio.dart';

import '../core/api_constant.dart';

class ApiClient {
  static late Dio dio;

  static init() async{
    dio =  Dio(
      BaseOptions(
        baseUrl: ApiConstant.baseUrl,
        receiveDataWhenStatusError: true,
      ),
    );
  }

  // ****************************************************

  Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,

    //required dynamic data,
  }) async {
    dio.options.headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    return await dio.post(
      url,
      options: Options(validateStatus: (_) => true),
      queryParameters: query,
      data: data,
    );
  }

   Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    dio.options.headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      'Authorization': "token $token",
    };
    return await dio.get(
      url,
      options: Options(validateStatus: (_) => true),
      queryParameters: query,
    );
  }
}