import 'package:pos_application_mobile/data/data_source/remote_data_sources/color_data_source.dart';
import 'package:pos_application_mobile/data/mappers/color_mapper.dart';
import 'package:pos_application_mobile/data/payloads/color_payload.dart';
import 'package:pos_application_mobile/domain/entities/color_entity.dart';
import 'package:pos_application_mobile/domain/repositories/repository.dart';

abstract class ColorRepository extends Repository {
  final ColorDataSource dataSource;
  final ColorMapper mapper;

  ColorRepository({
    required this.mapper,
    required this.dataSource
  });

  Future<List<ColorEntity>> fetchData(Map<String, dynamic>? queryParameters);
  Future<ColorEntity> storeData(ColorPayload payload);
  Future<void> deleteData(String id);
  Future<ColorEntity>  updateData(String id, ColorPayload payload);
}