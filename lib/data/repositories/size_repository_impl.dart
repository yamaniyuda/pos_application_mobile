
import 'package:pos_application_mobile/data/data_source/remote_data_sources/size_data_source.dart';
import 'package:pos_application_mobile/data/dtos/size_dto.dart';
import 'package:pos_application_mobile/data/mappers/size_mapper.dart';
import 'package:pos_application_mobile/data/payloads/size_payload.dart';
import 'package:pos_application_mobile/domain/entities/size_entity.dart';
import 'package:pos_application_mobile/domain/repositories/size_repository.dart';

class SizeRepositoryImpl extends SizeRepository {
  SizeRepositoryImpl()
    : super(
      mapper: SizeMapper(),
      dataSource: SizeDataSource()
    );

  @override
  Future<List<SizeEntity>> fetchData(Map<String, dynamic>? queryParameters) async {
    final List<SizeDTO> dataDTO = await dataSource.fetchData(queryParameters);
    final List<SizeEntity> dataEntity = List<SizeEntity>.from(
      dataDTO.map((dto) => mapper.convert<SizeDTO, SizeEntity>(dto))
    );
    return dataEntity;
  }

  @override
  Future<SizeEntity> storeData(SizePayload payload) async {
    final SizeDTO dataDTO = await dataSource.storeData(payload);
    final SizeEntity dataEntity = mapper.convert<SizeDTO, SizeEntity>(dataDTO);
    return dataEntity;
  }
  
  @override
  Future<void> deleteData(String id) async {
    await dataSource.deleteData(id);
  }
  
  @override
  Future<SizeEntity> updateData(SizePayload payload) async {
    final SizeDTO dataDTO = await dataSource.updateData(payload.id, payload);
    final SizeEntity dataEntity = mapper.convert<SizeDTO, SizeEntity>(dataDTO);

    return dataEntity;
  }

  @override
  Future<SizeEntity> fetchDetailData(String id, Map<String, dynamic> queryParameters) {
    throw UnimplementedError();
  }
}