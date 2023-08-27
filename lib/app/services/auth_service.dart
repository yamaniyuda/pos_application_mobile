// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:pos_application_mobile/app/config/routes/app_screens.dart';
import 'package:pos_application_mobile/app/extensions/string_extention.dart';
import 'package:pos_application_mobile/app/utils/di_container.dart';
import 'package:pos_application_mobile/data/payloads/sign_in_payload.dart';
import 'package:pos_application_mobile/domain/entities/auth_entity.dart';
import 'package:pos_application_mobile/domain/entities/user_entity.dart';
import 'package:pos_application_mobile/domain/use_cases/auth/logout_use_case.dart';
import 'package:pos_application_mobile/domain/use_cases/auth/me_use_case.dart';
import 'package:pos_application_mobile/domain/use_cases/auth/sign_in_use_case.dart';
import 'package:pos_application_mobile/presentation/app/main/main.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_alert/pam_alert.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_alert/pam_snackbar.dart';

const ACCESS_TOKEN_KEY = "auth_service_access_token_key";
const REFRESH_TOKEN_KEY = "auth_service_refresh_token_key";
const REMEMBER_ME_KEY = "auth_service_remember_me_key";
const ME_KEY = "auth_service_me_key";

class AuthService extends GetxService {
  final MeUseCase meUseCase;
  final SignInUseCase signInUseCase;
  final LogoutUseCase logoutUseCase;
  final FlutterSecureStorage storage;
  

  AuthService()
    : meUseCase = DIContainer().meUseCase,
      signInUseCase = DIContainer().signInUseCase,
      logoutUseCase = DIContainer().logoutUseCase,
      storage = const FlutterSecureStorage();

  static String OWNER = 'owner';
  static String RESELLER = 'reseller';
  static String KASIR = 'kasir';
  static String MANAGER  = 'manager';
  static String GUDANG = 'gudang';

  final Rx<UserEntity?> _userEntity = UserEntity().obs;
  UserEntity? get userEntity => _userEntity.value;

  final Rx<bool> _isLogin = false.obs;
  bool get isLogin => _isLogin.value;

  final Rx<AuthEntity?> _token = AuthEntity().obs;
  AuthEntity? get token => _token.value;

  final Rx<bool> _rememberMe = false.obs;
  bool get rememberMe => _rememberMe.value;
  set token(AuthEntity? newToken) {
    _token.value = newToken;
  }

  final Rx<bool> _isLoading = false.obs;
  bool get isLoading => _isLogin.value;

  Future<AuthService> init() async {
    await _setAllData();
    return this;
  }

  /// do clear data state when remember me null or false
  Future<void> clearState() async {
    _token.value = AuthEntity();
    _rememberMe.value = false;
    _isLoading.value = false;
    _isLogin.value = false;
    _userEntity.value = UserEntity();

    _deleteRememberMe();
  }

  /// for handling store all state to local storage
  Future<void> _storeState() async {
    storeRememberMe();
    if (_token.value != null) {
      _storeToken(_token.value!);
    }
    if (userEntity != null) {
      _storeMe();
    }
  }

  /// store access token and refresh token
  Future<void> _storeToken(AuthEntity auth) async {
    storage.write(key: ACCESS_TOKEN_KEY, value: auth.accessToken);
    storage.write(key: REFRESH_TOKEN_KEY, value: auth.refreshToken);
  }

  /// this function for handling store data remember me to local storage
  Future<void> storeRememberMe() async {
    await storage.write(
      key: REMEMBER_ME_KEY,
      value: _rememberMe.value.toString(),
      aOptions: const AndroidOptions(
        encryptedSharedPreferences: true
      )
    );
  }

  /// handling set all data when data remember
  Future<void> _setAllData() async {
    await _setRememberMe();
    await _setMe();
  }

  /// Fetch the user's data using [MeUseCase]
  Future<void> _setMe() async {
    final UserEntity? data = await meUseCase.call();

    if (data != null) {
      _userEntity.value = data;
    } else {
      _userEntity.value = UserEntity();
    }
  }

  /// handling store user entity / me data to local storage
  Future<void> _storeMe() async {
    await storage.write(
      key: ME_KEY,
      value: _userEntity.value?.serialize(),
      aOptions: const AndroidOptions(
        encryptedSharedPreferences: true
      )
    );
  }

  /// handling set again to state remember me
  Future<void> _setRememberMe() async {
    String? setRememberMe = await storage.read(
      key: REMEMBER_ME_KEY,
      aOptions: const AndroidOptions(
        encryptedSharedPreferences: true
      )
    );
    if (setRememberMe == null || setRememberMe.toLowerCase() == 'false') {
      _rememberMe.value = false;
    } else {
      _rememberMe.value = true;
    }
  }

  Future<void> _deleteRememberMe() async {
    await storage.delete(
      key: REMEMBER_ME_KEY,
      aOptions: const AndroidOptions(
        encryptedSharedPreferences: true
      )
    );
  }

  /// Sign in the user using the provide [payload]
  Future<void> signIn(SignInPayload payload, { bool rememberMe = false }) async {
    try {
      _isLoading.value = true;
      await signInUseCase.call(payload);
      await _setMe();

      if (rememberMe) {
        _rememberMe.value = true;
        _storeState();
      }

      Get.offAllNamed(Routes.main, arguments: { "screen": ChildMenuMain.homeScreen });
    }  on DioException catch (e) {
      Get.back();
      PAMSnackBarWidget.show(
        title: "failed".tr.toCapitalize(),
        message: e.response!.data["message"],
        type: PAMSnackBarWidgetType.danger
      );
    } catch (e) {
      Get.back();
      PAMSnackBarWidget.show(
        title: "Login Failed".tr,
        message: "Login failed, please try again".tr,
        type: PAMSnackBarWidgetType.danger
      );
    } 
  }

  Future<void> logout() async {
    PAMAlertWidget.showLoadingAlert(Get.context!);
    await logoutUseCase.call();
    clearState();
    Get.offAllNamed(Routes.auth);
  }
}