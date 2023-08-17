
import 'package:pos_application_mobile/data/data_source/remote_data_sources/color_data_source.dart';
import 'package:pos_application_mobile/data/dtos/color_dto.dart';
import 'package:pos_application_mobile/data/mappers/color_mapper.dart';
import 'package:pos_application_mobile/data/payloads/color_payload.dart';
import 'package:pos_application_mobile/domain/entities/color_entity.dart';
import 'package:pos_application_mobile/domain/repositories/color_repository.dart';

class ColorRepositoryImpl extends ColorRepository {
  ColorRepositoryImpl()
    : super(
      mapper: ColorMapper(),
      dataSource: ColorDataSource()
    );

  @override
  Future<List<ColorEntity>> fetchData(Map<String, dynamic>? queryParameters) async {
    final List<ColorDTO> dataDTO = await dataSource.fetchData(queryParameters);
    final List<ColorEntity> dataEntity = List<ColorEntity>.from(
      dataDTO.map((dto) => mapper.convert<ColorDTO, ColorEntity>(dto))
    );
    return dataEntity;
  }

  @override
  Future<ColorEntity> storeData(ColorPayload payload) async {
    final ColorDTO dataDTO = await dataSource.storeData(payload);
    final ColorEntity dataEntity = mapper.convert<ColorDTO, ColorEntity>(dataDTO);
    return dataEntity;
  }
  
  @override
  Future<void> deleteData(String id) async {
    await dataSource.deleteData(id);
  }
  
  @override
  Future<ColorEntity> updateData(String id, ColorPayload payload) async {
    final ColorDTO dataDTO = await dataSource.updateData(id, payload);
    final ColorEntity dataEntity = mapper.convert<ColorDTO, ColorEntity>(dataDTO);

    return dataEntity;
  }
}