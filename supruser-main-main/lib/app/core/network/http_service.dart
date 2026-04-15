import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:suprapp/app/core/utils/shared_preference_helper.dart';
import 'api_constants.dart';

class HttpService {
  late Dio dio;
  static HttpService? _instance;

  HttpService._() {
    dio = Dio(BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));

    if (kDebugMode) {
      dio.interceptors.add(LogInterceptor(
        requestBody: true,
        responseBody: true,
      ));
    }
  }

  static HttpService get instance {
    _instance ??= HttpService._();
    return _instance!;
  }

  Future<Map<String, String>> getHeaders() async {
    final token = await SharedPrefHelper.getAuthToken();
    return {
      if (token != null) 'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    };
  }

  Future<Response> get(String url, {Map<String, dynamic>? queryParameters}) async {
    try {
      final headers = await getHeaders();
      return await dio.get(
        url,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
    } on DioError catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> post(String url, dynamic data) async {
    try {
      final headers = await getHeaders();
      return await dio.post(
        url,
        data: data,
        options: Options(headers: headers),
      );
    } on DioError catch (e) {
      throw _handleError(e);
    }
  }

  String _handleError(DioError e) {
    if (e.response?.data is Map) {
      return e.response?.data['message'] ?? 'Something went wrong';
    }
    return e.message ?? 'Network error occurred';
  }
}