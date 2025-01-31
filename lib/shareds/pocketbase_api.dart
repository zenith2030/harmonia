import 'package:harmonia/shareds/client_http.dart';

class PocketBaseApi {
  static const String baseHttp = 'https://app.solutil.com.br/api/';
  static const String emailSuper = 'sistemaszenith@gmail.com';
  static const String passwordSuper = 'qDgmp@2030';
  final String collection;
  final ClientHttp client;

  PocketBaseApi({
    required this.collection,
    required this.client,
  });

  Future<List<Map<String, dynamic>>> getAll(
      {Map<String, dynamic>? params}) async {
    try {
      final result = await client.get(
        '$baseHttp$collection/records',
        params: params,
      );
      return result.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getById(
    String id, {
    Map<String, dynamic>? params,
  }) async {
    try {
      final result = await client.get(
        '$baseHttp$collection/records/$id',
        params: params,
      );
      return result.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> create({
    Map<String, dynamic>? body,
    Map<String, dynamic>? params,
  }) async {
    final result = await client.post(
      '$baseHttp$collection/records',
      body: body,
      params: params,
    );
    return result.data;
  }

  Future<Map<String, dynamic>> update(
    String id, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? params,
  }) async {
    final result = await client.patch(
      '$baseHttp$collection/records/$id',
      body: body,
      params: params,
    );
    return result.data;
  }

  Future<Map<String, dynamic>> delete(
    String id, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? params,
  }) async {
    final result = await client.delete(
      '$baseHttp$collection/records/$id',
      body: body,
      params: params,
    );
    return result.data;
  }
}
