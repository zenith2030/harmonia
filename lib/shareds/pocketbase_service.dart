import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';

class PocketBaseService {
  static const String emailSuper = 'sistemaszenith@gmail.com';
  static const String passwordSuper = 'qDgmp@2030';
  late final PocketBase pb;
  final String collectionModel;

  PocketBaseService(this.collectionModel) {
    pb = PocketBase('https://solutil.com.br');
    login(emailSuper, passwordSuper);
  }

  Future<ResultList<RecordModel>> getAll() async {
    try {
      final result = await pb.collection(collectionModel).getList();
      return result;
    } catch (e) {
      if (e is ClientException && e.statusCode == 404) {
        return ResultList<RecordModel>(
          items: [],
          totalItems: 0,
          page: 0,
          perPage: 0,
          totalPages: 0,
        );
      } else {
        rethrow;
      }
    }
  }

  Future<RecordModel> getById(String id) async {
    return pb.collection(collectionModel).getOne(id);
  }

  Future<RecordModel> add(Map<String, dynamic> model) {
    return pb.collection(collectionModel).create(body: model);
  }

  Future<RecordModel> update(String id, Map<String, dynamic> model) async {
    return pb.collection(collectionModel).update(id, body: model);
  }

  Future<void> delete(String id) {
    return pb.collection(collectionModel).delete(id);
  }

  logout() {
    pb.authStore.clear();
  }

  Future<bool> isLogged() async {
    return pb.authStore.isValid;
  }

  Future<void> login(String email, String password) async {
    await pb.collection('_superusers').authWithPassword(email, password);
    //pb.authStore.save(authData.token, authData.record);
    if (pb.authStore.isValid) {
      debugPrint('Logged in as Token: ${pb.authStore.token}');
      debugPrint('Logged in as ID: ${pb.authStore.record?.id}');
    }
  }

  Future<void> register(String email, String password) async {
    await pb
        .collection('_superusers')
        .authWithPassword(emailSuper, passwordSuper);

    if (pb.authStore.isValid) {
      await pb.collection('users').create(body: {
        'email': email,
        'password': password,
        'passwordConfirm': password,
      });
    }
  }
}
