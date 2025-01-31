import 'package:dio/dio.dart';
import 'package:harmonia/shareds/errors/http_error.dart';

class ClientHttp {
  final Dio dio;
  ClientHttp(this.dio);

  Future<Response> get(
    String path, {
    Map<String, String>? headers,
    Map<String, dynamic>? params,
  }) async {
    Options option = _options(headers);
    final response = await dio
        .get(path, queryParameters: params, options: option)
        .catchError((error) => _onError(error));
    return response;
  }

  Future<Response> post(String path,
      {Map<String, dynamic>? body,
      Map<String, String>? headers,
      Map<String, dynamic>? params}) async {
    Options option = _options(headers);
    final response = await dio
        .post(path, data: body, queryParameters: params, options: option)
        .catchError((error) => _onError(error));
    return response;
  }

  Future<Response> patch(String path,
      {Map<String, dynamic>? body,
      Map<String, String>? headers,
      Map<String, dynamic>? params}) async {
    Options option = _options(headers);
    final response = await dio
        .patch(path, data: body, queryParameters: params, options: option)
        .catchError((error) => _onError(error));
    return response;
  }

  Future<Response> delete(String path,
      {Map<String, dynamic>? body,
      Map<String, String>? headers,
      Map<String, dynamic>? params}) async {
    Options option = _options(headers);
    final response = await dio
        .delete(path, data: body, queryParameters: params, options: option)
        .catchError((error) => _onError(error));
    return response;
  }

  _onError(dynamic error) {
    if (error is DioException && error.type == DioExceptionType.badResponse) {
      throw HttpResponseError(message: error.toString());
    }
    throw error;
  }

  Options _options(Map<String, String>? headers) {
    return Options(
      receiveTimeout: Duration(seconds: 5),
      sendTimeout: Duration(seconds: 5),
      headers: {
        'content-type': 'application/json',
        ...?headers,
      },
    );
  }
}
