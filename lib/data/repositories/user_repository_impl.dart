import 'package:pos_application_mobile/data/data_source/remote_data_sources/user_data_source.dart';
import 'package:pos_application_mobile/data/dtos/user_dto.dart';
import 'package:pos_application_mobile/data/mappers/user_mapper.dart';
import 'package:pos_application_mobile/data/payloads/user_payload.dart';
import 'package:pos_application_mobile/domain/entities/user_entity.dart';
import 'package:pos_application_mobile/domain/repositories/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  UserRepositoryImpl()
    : super(
      dataSource: UserDataSource(),
      mapper: UserMapper()
    );

  @override
  Future<void> deleteData(String id) async {
    await dataSource.deleteData(id);
  }

  @override
  Future<List<UserEntity>> fetchData(Map<String, dynamic> queryParameters) async {
    final List<UserDTO> dataDTO = await dataSource.fetchData(queryParameters);
    final List<UserEntity> dataEntity = List<UserEntity>.from(
      dataDTO.map((e) => mapper.convert<UserDTO, UserEntity>(e))
    );
    return dataEntity;
  }

  @override
  Future<UserEntity> fetchDetailData(String id, Map<String, dynamic>? queryParameters) async {
    final UserDTO dataDTO = await dataSource.fetchDetailData(id, queryParameters);
    final UserEntity dataEntity = mapper.convert<UserDTO, UserEntity>(dataDTO);
    return dataEntity;
  }

  @override
  Future<UserEntity> storeData(UserPaylaod paylaod) async {
    final UserDTO dataDTO = await dataSource.storeData(paylaod);
    final UserEntity dataEntity = mapper.convert<UserDTO, UserEntity>(dataDTO);
    return dataEntity;
  }

  @override
  Future<UserEntity> updateData(UserPaylaod paylaod) async {
    final UserDTO dataDTO = await dataSource.updateData(paylaod.id, paylaod);
    final UserEntity dataEntity = mapper.convert<UserDTO, UserEntity>(dataDTO);
    return dataEntity;
  }
}