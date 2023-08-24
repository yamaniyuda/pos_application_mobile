import 'package:pos_application_mobile/data/dtos/auth_dto.dart';
import 'package:pos_application_mobile/data/dtos/user_dto.dart';

import 'local_data_source.dart';

class AuthDataSource extends LocalDataSource {
  final String _keyAuth = "store_auth";
  final String _keyAuthToken = "store_auth_token";
  final String _keyAuthMe = "store_auth_me";

  Future<bool> storeData(AuthDTO data) async {
    try {
      await storage.write(
          key: _keyAuth,
          value: data.serialize(),
          aOptions: getAndroidOptions(),
          iOptions: getIosOptions()
      );
      await storeToken(data.accessToken!);
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

  Future<String> getToken() async {
    String? data = await storage.read(
      key: _keyAuthToken,
      aOptions: getAndroidOptions(),
      iOptions: getIosOptions()
    );
    
    return "Bearer $data";
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

  Future<void> storeMe(UserDTO userDTO) async {
    await storage.write(
      key: _keyAuthMe,
      value: userDTO.serialize(),
      aOptions: getAndroidOptions(),
      iOptions: getIosOptions()
    );
  }

  Future<UserDTO?> getMe() async {
    String? data = await storage.read(
      key: _keyAuthMe,
      aOptions: getAndroidOptions(),
      iOptions: getIosOptions()
    );

    if (data != null) {
      return UserDTO.deserialize(data);
    }

    return null;
  }

  Future<void> deleteMe() async {
    await storage.delete(
      key: _keyAuthMe,
      aOptions: getAndroidOptions(),
      iOptions: getIosOptions()
    );
  }
}