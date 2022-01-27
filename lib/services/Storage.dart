import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage{
  static final _storage = FlutterSecureStorage();

  write(String key,String value) async {
    await _storage.write(key: key, value: value);
  }

  read(key) async {
    var token = await _storage.read(key: key);
    return token;
  }

  delete(key) async {
    await _storage.delete(key: key);
  }
}