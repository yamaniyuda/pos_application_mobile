import 'package:pos_application_mobile/data/data_source/remote_data_sources/cloth_data_source.dart';
import 'package:pos_application_mobile/data/mappers/cloth_mapper.dart';
import 'package:pos_application_mobile/data/payloads/cloth_color_payload.dart';
import 'package:pos_application_mobile/data/payloads/cloth_payload.dart';
import 'package:pos_application_mobile/domain/entities/cloth_color_entity.dart';
import 'package:pos_application_mobile/domain/entities/cloth_entity.dart';
import 'package:pos_application_mobile/domain/repositories/repository.dart';

abstract class ClothRepository extends Repository {
  final ClothDataSource dataSource;
  final ClothMapper mapper;

  ClothRepository({
    required this.mapper,
    required this.dataSource
  });

  Future<List<ClothEntity>> fetchData(Map<String, dynamic>? queryParameters);
  Future<ClothEntity> fetchDetailData(String id, Map<String, dynamic>? queryParameters);
  Future<String> storeData(ClothPayload payload);
  Future<void> deleteData(String id);
  Future<ClothEntity>  updateData(String id, ClothPayload payload);
  Future<void> addClothColor(String id, ClothPayload payload);
  Future<void> addClothSize(String id, String colorId, ClothColorPayload payload);
  Future<ClothColorEntity> fetchDataBySku(String sku, String customerCategoryId);
} 