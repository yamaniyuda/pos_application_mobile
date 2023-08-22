import 'package:pos_application_mobile/data/data_source/remote_data_sources/cloth_category_data_source.dart';
import 'package:pos_application_mobile/data/mappers/cloth_category_mapper.dart';
import 'package:pos_application_mobile/data/payloads/cloth_category_payload.dart';
import 'package:pos_application_mobile/domain/entities/cloth_category_entity.dart';
import 'package:pos_application_mobile/domain/repositories/repository.dart';

abstract class ClothCategoryRepository extends Repository {
  final ClothCategoryDataSource dataSource;
  final $ClothCategoryMapper mapper;

  ClothCategoryRepository({
    required this.dataSource,
    required this.mapper
  });

  Future<List<ClothCategoryEntity>> fetchData(Map<String, dynamic>? queryParameters);
  Future<ClothCategoryEntity> fetchDetailData(String id, Map<String, dynamic> queryParameters);
  Future<ClothCategoryEntity> storeData(ClothCategoryPayload paylaod);
  Future<ClothCategoryEntity> updateData(ClothCategoryPayload params);
  Future<void> deleteData(String id); 
}