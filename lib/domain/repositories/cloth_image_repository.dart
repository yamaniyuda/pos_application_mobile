import 'package:pos_application_mobile/data/data_source/remote_data_sources/cloth_image_data_source.dart';
import 'package:pos_application_mobile/data/mappers/cloth_image_mapper.dart';
import 'package:pos_application_mobile/data/payloads/cloth_image_payload.dart';
import 'package:pos_application_mobile/domain/entities/cloth_image_entity.dart';
import 'package:pos_application_mobile/domain/repositories/repository.dart';

abstract class ClothImageRepository extends Repository {
  final ClothImageDataSource dataSource;
  final ClothImageMapper mapper;

  ClothImageRepository({
    required this.dataSource,
    required this.mapper
  });

  Future<List<ClothImageEntity>> fetchData(Map<String, dynamic>? queryParameters);
  Future<ClothImageEntity> fetchDetailData(String id, Map<String, dynamic> queryParameters);
  Future<ClothImageEntity> storeData(ClothImagePayload paylaod);
  Future<ClothImageEntity> updateData(ClothImagePayload params);
  Future<void> deleteData(String id); 
}