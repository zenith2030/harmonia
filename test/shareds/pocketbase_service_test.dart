import 'package:flutter_test/flutter_test.dart';
import 'package:pocketbase/pocketbase.dart';

void main() {
  testWidgets('pocketbase service ...', (_) async {
    String email = 'sistemaszenith@gmail.com';
    String password = 'qDgmp@2030';
    String tableName = 'trilha_sonora';
    final pb = PocketBase('app.solutil.com.br');
    await pb.collection('users').authWithPassword(email, password);
    print(pb.authStore.isValid);
    print(pb.authStore.token);
    print(pb.authStore.record);

    pb.collection(tableName).subscribe('*', (e) {
      print(e.action);
      print(e.record);
    });

    RecordModel trilha =
        await pb.collection(tableName).create(body: {'nome': 'Trilha 1'});

    expect(pb.authStore.isValid, true);
    expect(trilha.id, isNotNull);
    expect(trilha.get('nome'), 'Trilha 1');
  });
}
