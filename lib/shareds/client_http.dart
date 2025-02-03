import 'package:dio/dio.dart';
import 'package:harmonia/auth/domain/entities/user.dart';

class ClientHttp {
  static User? _user;
  Dio dio = Dio();
  ClientHttp(this.dio);

  Future<Response> get(
    String path, {
    Map<String, String>? headers,
    Map<String, dynamic>? params,
  }) async {
    Options option = _options(headers);
    final response = await dio.get(
      path,
      queryParameters: params,
      options: option,
    );
    return _reponse(response);
  }

  Future<Response> post(String path,
      {Map<String, dynamic>? body,
      Map<String, String>? headers,
      Map<String, dynamic>? params}) async {
    Options option = _options(headers);
    final response = await dio.post(
      path,
      data: body,
      queryParameters: params,
      options: option,
    );
    return _reponse(response, body);
  }

  Future<Response> patch(String path,
      {Map<String, dynamic>? body,
      Map<String, String>? headers,
      Map<String, dynamic>? params}) async {
    Options option = _options(headers);
    final response = await dio.patch(
      path,
      data: body,
      queryParameters: params,
      options: option,
    );
    return _reponse(response, body);
  }

  Future<Response> delete(String path,
      {Map<String, dynamic>? body,
      Map<String, String>? headers,
      Map<String, dynamic>? params}) async {
    Options option = _options(headers);
    final response = await dio.delete(
      path,
      data: body,
      queryParameters: params,
      options: option,
    );
    return _reponse(response, body);
  }

  // _onError(dynamic error) {
  //   if (error is DioException && error.type == DioExceptionType.badResponse) {
  //     throw HttpResponseError(message: error.toString());
  //   }
  //   throw error;
  // }

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

  Response _reponse(Response response, [Map<String, dynamic>? body]) {
    if (_user != null) {
      (response.data as Map)['user'] = _user!.toJson();
      (response.data as Map)['user_id'] = _user!.id;
    }
    if (response.statusMessage?.toLowerCase() == "ok") {
      final data = response.data as Map<String, dynamic>;
      data.remove('password');
      data.remove('passwordConfirm');
      body?.remove('password');
      body?.remove('passwordConfirm');
      response.data = {...data, ...?body};
    }
    return response;
  }

  setToken(User? user, String token) {
    _user = user;
    dio.options.headers['Authorization'] = token;
    dio.options.headers['X-User-Id'] = user?.id;
    dio.options.headers['X-User-Email'] = user?.email;
    dio.options.headers['X-User-Name'] = user?.name;
    dio.options.headers['X-User-Avatar'] = user?.avatar;
    dio.options.headers['X-User-Verified'] = user?.verified;
  }

  clearToken() {
    _user = null;
    dio.options.headers.remove('Authorization');
    dio.options.headers.remove('X-User-Id');
    dio.options.headers.remove('X-User-Email');
    dio.options.headers.remove('X-User-Name');
    dio.options.headers.remove('X-User-Avatar');
    dio.options.headers.remove('X-User-Verified');
  }
}
