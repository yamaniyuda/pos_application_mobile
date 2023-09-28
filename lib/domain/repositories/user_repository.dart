import 'package:pos_application_mobile/data/data_source/remote_data_sources/user_data_source.dart';
import 'package:pos_application_mobile/data/mappers/user_mapper.dart';
import 'package:pos_application_mobile/data/payloads/user_payload.dart';
import 'package:pos_application_mobile/domain/entities/user_entity.dart';
import 'package:pos_application_mobile/domain/repositories/repository.dart';

abstract class UserRepository extends Repository {
  final UserDataSource dataSource;
  final UserMapper mapper;

  UserRepository({
    required this.dataSource,
    required this.mapper
  });

  Future<List<UserEntity>> fetchData(Map<String, dynamic> queryParameters);
  Future<UserEntity> fetchDetailData(String id, Map<String, dynamic>? queryParameters);
  Future<UserEntity> storeData(UserPaylaod paylaod);
  Future<UserEntity> updateData(UserPaylaod params);
  Future<void> deleteData(String id); 
}