import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class LocalDataSource {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  FlutterSecureStorage get storage => _storage;

  AndroidOptions getAndroidOptions() {
    return const AndroidOptions(
      encryptedSharedPreferences: true
    );
  }

  IOSOptions getIosOptions() {
    return const IOSOptions(
      accountName: "ios_secure_storage"
    );
  }
}