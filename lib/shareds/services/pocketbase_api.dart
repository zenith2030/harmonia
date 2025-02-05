import 'package:harmonia/shareds/services/client_http.dart';

class PocketBaseApi {
  static const String baseHttp = 'https://app.solutil.com.br/api/';
  final String collection;
  final ClientHttp client;

  PocketBaseApi({
    required this.collection,
    required this.client,
  }) {
    client.post('$baseHttp$collection/records', params: {'sort': '-created'});
  }

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
