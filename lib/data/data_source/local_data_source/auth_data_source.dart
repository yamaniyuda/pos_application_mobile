import 'package:pos_application_mobile/data/dtos/auth_dto.dart';

import 'local_data_source.dart';

class AuthDataSource extends LocalDataSource {
  final String _keyAuth = "store_auth";
  final String _keyAuthToken = "store_auth_token";

  Future<bool> storeData(AuthDTO data) async {
    try {
      await storage.write(
          key: _keyAuth,
          value: data.serialize(),
          aOptions: getAndroidOptions(),
          iOptions: getIosOptions()
      );
      await storeToken(data.token!);
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<bool> storeToken(String token) async {
    try {
      await storage.write(
        key: _keyAuthToken,
        value: token,
        aOptions: getAndroidOptions(),
        iOptions: getIosOptions()
      );
      return true;
    } catch (_) {
      return false;
    }
  }
  
  Future<AuthDTO?> getData() async {
    String? data = await storage.read(
      key: _keyAuth,
      aOptions: getAndroidOptions(),
      iOptions: getIosOptions()
    );

    if (data != null) {
      return AuthDTO.deserialize(data);
    }

    return null;
  }

  Future<String?> getToken() async {
    String? data = await storage.read(
      key: _keyAuthToken,
      aOptions: getAndroidOptions(),
      iOptions: getIosOptions()
    );

    return data;
  }

  Future<void> deleteData() async {
    await storage.delete(
      key: _keyAuth,
      aOptions: getAndroidOptions(),
      iOptions: getIosOptions()
    );
  }

  Future<void> deleteToken() async {
    await storage.delete(
      key: _keyAuthToken,
      aOptions: getAndroidOptions(),
      iOptions: getIosOptions()
    );
  }
}