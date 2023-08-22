
import 'package:pos_application_mobile/data/data_source/remote_data_sources/district_data_source.dart';
import 'package:pos_application_mobile/data/dtos/district_dto.dart';
import 'package:pos_application_mobile/data/mappers/district_mapper.dart';
import 'package:pos_application_mobile/domain/entities/district_entity.dart';
import 'package:pos_application_mobile/domain/repositories/district_repository.dart';

class DistrictRepositoryImpl extends DistrictRepository {
  DistrictRepositoryImpl()
    : super(
      mapper: DistrictMapper(),
      dataSource: DistrictDataSource()
    );

  @override
  Future<List<DistrictEntity>> fetchData(Map<String, dynamic>? queryParameters) async {
    final List<DistrictDTO> dataDTO = await dataSource.fetchData(queryParameters);
    final List<DistrictEntity> dataEntity = List<DistrictEntity>.from(
      dataDTO.map((dto) => mapper.convert<DistrictDTO, DistrictEntity>(dto))
    );
    return dataEntity;
  }
}