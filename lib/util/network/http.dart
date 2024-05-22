import 'package:bookclub/util/storage/storage.dart';
import 'package:dio/dio.dart';

class HttpHelper {
  static Dio? _client;

  static Future<Dio?> _getInstance(
      {bool? isAuth, Map<String, dynamic>? headers}) async {
    _client ??= Dio();

    _client?.options.baseUrl = await getApiBaseUrl();

    if (isAuth == true) {
      _client?.options.headers = {"Content-Type": "x-www-form-urlencoded"};

      return _client;
    }

    if (headers != null) {
      _client?.options.headers = headers;
      return _client;
    }

    final token = await StorageHelper.get('token');

    _client?.options.headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    return _client;
  }

  static getApiBaseUrl() async {
    // return 'http://localhost:8000';
    return 'https://api-book-club.azurewebsites.net';
  }

  static Future<Response> get(String endpoint,
      {Map<String, dynamic>? headers}) async {
    final instance = await _getInstance(headers: headers);
    return instance!.get(endpoint);
  }

  static Future<Response> post(String endpoint,
      {Map<String, dynamic>? body, Map<String, dynamic>? headers}) async {
    final instance = await _getInstance(headers: headers);
    return instance!.post(endpoint, data: body);
  }

  static Future<Response> put(String endpoint,
      {Map<String, dynamic>? body, Map<String, dynamic>? headers}) async {
    final instance = await _getInstance(headers: headers);
    return instance!.put(endpoint, data: body);
  }

  static Future<Response> delete(String url,
      {Map<String, dynamic>? body, Map<String, dynamic>? headers}) async {
    final instance = await _getInstance(headers: headers);
    return instance!.delete(url, data: body);
  }

  static String? getError(dynamic e) {
    if (e.response != null && e.response?.data != null) {
      if (e.response?.data.runtimeType == String) {
        return e.response?.data.toString();
      }

      if (e.response?.data["data"] != null) {
        return e.response?.data["data"];
      }
      if (e.response?.data["error"] != null) {
        return e.response?.data["error"].toString();
      }
    }

    if (e.error != null) {
      return e.error.toString();
    } else {
      return "Erro desconhecido";
    }
  }
}
