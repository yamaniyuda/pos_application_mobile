
import 'package:pos_application_mobile/data/data_source/remote_data_sources/village_data_source.dart';
import 'package:pos_application_mobile/data/dtos/village_dto.dart';
import 'package:pos_application_mobile/data/mappers/village_mapper.dart';
import 'package:pos_application_mobile/domain/entities/village_entity.dart';
import 'package:pos_application_mobile/domain/repositories/village_repository.dart';

class VillageRepositoryImpl extends VillageRepository {
  VillageRepositoryImpl()
    : super(
      mapper: VillageMapper(),
      dataSource: VillageDataSource()
    );

  @override
  Future<List<VillageEntity>> fetchData(Map<String, dynamic>? queryParameters) async {
    final List<VillageDTO> dataDTO = await dataSource.fetchData(queryParameters);
    final List<VillageEntity> dataEntity = List<VillageEntity>.from(
      dataDTO.map((dto) => mapper.convert<VillageDTO, VillageEntity>(dto))
    );
    return dataEntity;
  }
}