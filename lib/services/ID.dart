import 'package:uuid/uuid.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final _secureStorage = FlutterSecureStorage();
final _idKey = 'device_install_id';

Future<String> getOrCreateInstallId() async {
  String? id = await _secureStorage.read(key: _idKey);
  if (id == null) {
    id = Uuid().v4();
    await _secureStorage.write(key: _idKey, value: id);
  }
  return id;
}
