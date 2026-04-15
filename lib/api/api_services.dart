import 'dart:convert';

import 'package:dio/dio.dart';
import 'api_config.dart';

class APIService {

  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: APIConfig.baseUrl,
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      sendTimeout: const Duration(seconds: 60),
      receiveDataWhenStatusError: true,
    ),
  );

  static Future<Map<String, dynamic>> sendFormData({
    required String endpoint,
    required FormData formData,
    Map<String, dynamic>? params,
    String? token,
  }) async {
    final headers = {
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    };
    var response = await _dio.post(
      endpoint,
      data: formData,
      queryParameters: params ?? {},
      options: Options(headers: headers),
    );
    if (response.data is Map<String, dynamic>) {
      return response.data;
    } else {
      return {'data': response.data};
    }
  }

  static Future<Map<String, dynamic>> post({
    required String endpoint,
    Map<String, dynamic>? body,
    Map<String, dynamic>? params,
    String? token,
    String? deviceToken,
  }) async {
    _dio.options.headers = {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
      if (deviceToken != null) 'device_token': deviceToken,
    };
    var response = await _dio.post(
      endpoint,
      data: body != null ? jsonEncode(body) : null,
      queryParameters: params ?? {},
    );
    if (response.data is Map<String, dynamic>) {
      return response.data;
    } else {
      return {'data': response.data};
    }
  }

  static Future<Map<String, dynamic>> get({
    required String endpoint,
    Map<String, dynamic>? params,
    Map<String, dynamic>? body,
    String? token,
  }) async {
    _dio.options.headers = {'Authorization': 'Bearer $token'};
    var response = await _dio.get(
      endpoint,
      data: body,
      queryParameters: params ?? {},
    );
    if (response.data is Map<String, dynamic>) {
      return response.data;
    } else {
      return {'data': response};
    }
  }

  static Future<Map<String, dynamic>> delete({
    required String endpoint,
    Map<String, dynamic>? body,
    Map<String, dynamic>? params,
    String? token,
  }) async {
    _dio.options.headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var response = await _dio.delete(
      endpoint,
      data: body,
      queryParameters: params ?? {},
    );
    return response.data;
  }

  static Future<Map<String, dynamic>> put({
    required String endpoint,
    Map<String, dynamic>? body,
    Map<String, dynamic>? params,
    String? token,
  }) async {
    _dio.options.headers = {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
    var response = await _dio.put(
      endpoint,
      data: body,
      queryParameters: params ?? {},
    );
    return response.data;
  }

  static Future<Map<String, dynamic>> patch({
    required String endpoint,
    Map<String, dynamic>? body,
    Map<String, dynamic>? params,
    String? token,
  }) async {
    _dio.options.headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var response = await _dio.patch(
      endpoint,
      data: body,
      queryParameters: params ?? {},
    );
    return response.data;
  }

  static Future<Map<String, dynamic>> deleteFormData({
    required String endpoint,
    required FormData formData,
    Map<String, dynamic>? params,
    String? token,
  }) async {
    final headers = {
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    };
    var response = await _dio.delete(
      endpoint,
      data: formData,
      queryParameters: params ?? {},
      options: Options(headers: headers),
    );
    if (response.data is Map<String, dynamic>) {
      return response.data;
    } else {
      return {'data': response.data};
    }
  }
  static Future<Map<String, dynamic>> putFormData({
    required String endpoint,
    required FormData formData,
    Map<String, dynamic>? params,
    String? token,
  }) async {
    final headers = {
      'Content-Type': 'multipart/form-data',
      if (token != null) 'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    };

    var response = await _dio.put(
      endpoint,
      data: formData,
      options: Options(headers: headers),
    );

    return response.data is Map<String, dynamic> ? response.data : {'data': response.data};
  }
}