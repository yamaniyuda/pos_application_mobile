import 'package:pos_application_mobile/data/data_source/local_data_source/auth_data_source.dart' as local;
import 'package:pos_application_mobile/data/data_source/remote_data_sources/auth_data_source.dart' as remote;
import 'package:pos_application_mobile/data/dtos/auth_dto.dart';
import 'package:pos_application_mobile/data/dtos/user_dto.dart';
import 'package:pos_application_mobile/data/mappers/auth_mapper.dart';
import 'package:pos_application_mobile/data/mappers/user_mapper.dart';
import 'package:pos_application_mobile/data/payloads/sign_in_payload.dart';
import 'package:pos_application_mobile/domain/entities/auth_entity.dart';
import 'package:pos_application_mobile/domain/entities/user_entity.dart';
import 'package:pos_application_mobile/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  AuthRepositoryImpl()
    : super(
        mapper: AuthMapper(),
        remoteDataSource: remote.AuthDataSource(),
        localDataSource: local.AuthDataSource(),
        userMapper: UserMapper()
    );

  @override
  Future<void> logout() async {
    await remoteDataSource.logout();
  }

  @override
  Future<UserEntity?> me() async {
    try {
      UserDTO? authMe = await localDataSource.getMe();

      if (authMe == null) {
        final UserDTO dataDTO = await remoteDataSource.me();
        await localDataSource.storeMe(dataDTO);
        authMe = dataDTO;
      }

      return userMapper.convert<UserDTO, UserEntity>(authMe);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<AuthEntity> signIn(SignInPayload payload) async {
    try {
      final AuthDTO dataDTO = await remoteDataSource.singIn(payload: payload);
      final AuthEntity dataEntity = mapper.convert<AuthDTO, AuthEntity>(dataDTO);
      await localDataSource.storeData(dataDTO);

      return dataEntity;
    }  catch (e) {
      rethrow;
    }
  }

  @override
  /// get Token from local storage
  Future<String> getToken() async {
    return await localDataSource.getToken();
  }
}