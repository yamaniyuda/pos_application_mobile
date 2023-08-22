
import 'package:pos_application_mobile/data/data_source/remote_data_sources/provincy_data_source.dart';
import 'package:pos_application_mobile/data/dtos/provincy_dto.dart';
import 'package:pos_application_mobile/data/mappers/provincy_mapper.dart';
import 'package:pos_application_mobile/domain/entities/provincy_entity.dart';
import 'package:pos_application_mobile/domain/repositories/provindy_repository.dart';

class ProvincyRepositoryImpl extends ProvincyRepository {
  ProvincyRepositoryImpl()
    : super(
      mapper: ProvincyMapper(),
      dataSource: ProvincyDataSource()
    );

  @override
  Future<List<ProvincyEntity>> fetchData(Map<String, dynamic>? queryParameters) async {
    final List<ProvincyDTO> dataDTO = await dataSource.fetchData(queryParameters);
    final List<ProvincyEntity> dataEntity = List<ProvincyEntity>.from(
      dataDTO.map((dto) => mapper.convert<ProvincyDTO, ProvincyEntity>(dto))
    );
    return dataEntity;
  }
}