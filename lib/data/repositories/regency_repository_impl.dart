
import 'package:pos_application_mobile/data/data_source/remote_data_sources/regency_data_source.dart';
import 'package:pos_application_mobile/data/dtos/regency_dto.dart';
import 'package:pos_application_mobile/data/mappers/regency_mapper.dart';
import 'package:pos_application_mobile/domain/entities/regency_entity.dart';
import 'package:pos_application_mobile/domain/repositories/regency_repository.dart';

class RegencyRepositoryImpl extends RegencyRepository {
  RegencyRepositoryImpl()
    : super(
      mapper: RegencyMapper(),
      dataSource: RegencyDataSource()
    );

  @override
  Future<List<RegencyEntity>> fetchData(Map<String, dynamic>? queryParameters) async {
    final List<RegencyDTO> dataDTO = await dataSource.fetchData(queryParameters);
    final List<RegencyEntity> dataEntity = List<RegencyEntity>.from(
      dataDTO.map((dto) => mapper.convert<RegencyDTO, RegencyEntity>(dto))
    );
    return dataEntity;
  }
}