import 'package:pos_application_mobile/data/data_source/remote_data_sources/cloth_price_type_data_source.dart';
import 'package:pos_application_mobile/data/mappers/cloth_price_type_mapper.dart';
import 'package:pos_application_mobile/data/payloads/cloth_price_type_payload.dart';
import 'package:pos_application_mobile/domain/entities/cloth_price_type_entity.dart';
import 'package:pos_application_mobile/domain/repositories/repository.dart';

abstract class ClothPriceTypeRepository extends Repository {
  final ClothPriceTypeDataDataSource dataSource;
  final ClothPriceTypeMapper mapper;

  ClothPriceTypeRepository({
    required this.mapper,
    required this.dataSource
  });

  Future<List<ClothPriceTypeEntity>> fetchData(Map<String, dynamic>? queryParameters);
  Future<ClothPriceTypeEntity> fetchDetailData(String id, Map<String, dynamic>? queryParameters);
  Future<ClothPriceTypeEntity> storeData(ClothPriceTypePayload payload);
  Future<void> deleteData(String id);
  Future<ClothPriceTypeEntity>  updateData(String id, ClothPriceTypePayload payload);
} 