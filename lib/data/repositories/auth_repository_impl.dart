import 'package:pos_application_mobile/data/data_source/local_data_source/auth_data_source.dart' as local;
import 'package:pos_application_mobile/data/data_source/remote_data_sources/auth_data_source.dart' as remote;
import 'package:pos_application_mobile/data/dtos/auth_dto.dart';
import 'package:pos_application_mobile/data/mappers/auth_mapper.dart';
import 'package:pos_application_mobile/data/payloads/sign_in_payload.dart';
import 'package:pos_application_mobile/domain/entities/user_entity.dart';
import 'package:pos_application_mobile/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  AuthRepositoryImpl()
    : super(
        mapper: AuthMapper(),
        remoteDataSource: remote.AuthDataSource(),
        localDataSource: local.AuthDataSource()
    );

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<UserEntity> me() {
    // TODO: implement me
    throw UnimplementedError();
  }

  @override
  Future<bool> signIn(SignInPayload payload) async {
    try {
      final AuthDTO dataDTO = await remoteDataSource.singIn(payload: payload);
      await localDataSource.storeData(dataDTO);

      return true;
    }  catch (e, f) {
      return false;
    }
  }
}