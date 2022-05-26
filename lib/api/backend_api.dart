import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class BackendConnection {
  static final Dio _dio = Dio();

  static void dioConfiguration() {
    _dio.options.baseUrl = dotenv.env['BASE_URL'].toString();
    _dio.options.headers = {
      'x-token': dotenv.env['TOKEN'] ?? '',
    };
  }

  static Future getHttp(String path) async {
    try {
      _dio.options.headers = {
        'x-token': dotenv.env['TOKEN'] ?? '',
      };
      final resp = await _dio.get(path);
      return resp.data;
    } catch (e) {
      print('Error DIO: \n' + e.toString());
    }
  }

  static Future postHttp(String path, Map<String, dynamic> data) async {
    try {
      _dio.options.headers = {
        'x-token': dotenv.env['TOKEN'] ?? '',
      };
      final resp = await _dio.post(path, data: jsonEncode(data));
      return resp.data;
    } catch (e) {
      print('Error DIO: \n' + e.toString());
    }
  }
}
