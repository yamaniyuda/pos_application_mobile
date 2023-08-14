import 'package:pos_application_mobile/data/data_source/local_data_source/auth_data_source.dart' as local;
import 'package:pos_application_mobile/data/data_source/remote_data_sources/auth_data_source.dart' as remote;
import 'package:pos_application_mobile/data/mappers/auth_mapper.dart';
import 'package:pos_application_mobile/data/mappers/user_mapper.dart';
import 'package:pos_application_mobile/data/payloads/sign_in_payload.dart';
import 'package:pos_application_mobile/domain/entities/auth_entity.dart';
import 'package:pos_application_mobile/domain/entities/user_entity.dart';
import 'package:pos_application_mobile/domain/repositories/repository.dart';

abstract class AuthRepository extends Repository {
  final remote.AuthDataSource remoteDataSource;
  final local.AuthDataSource localDataSource;
  final AuthMapper mapper;
  final UserMapper userMapper;

  AuthRepository({
    required this.mapper,
    required this.remoteDataSource,
    required this.localDataSource,
    required this.userMapper
  });

  Future<AuthEntity> signIn(SignInPayload  payload);
  Future<void> logout();
  Future<UserEntity?> me();
  Future<String> getToken();
}