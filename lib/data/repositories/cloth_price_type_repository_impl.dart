
import 'package:pos_application_mobile/data/data_source/remote_data_sources/cloth_price_type_data_source.dart';
import 'package:pos_application_mobile/data/dtos/cloth_price_type_dto.dart';
import 'package:pos_application_mobile/data/mappers/cloth_price_type_mapper.dart';
import 'package:pos_application_mobile/data/payloads/cloth_price_type_payload.dart';
import 'package:pos_application_mobile/domain/entities/cloth_price_type_entity.dart';
import 'package:pos_application_mobile/domain/repositories/cloth_price_type_repository.dart';

class ClothPriceTypeRepositoryImpl extends ClothPriceTypeRepository {
  ClothPriceTypeRepositoryImpl()
    : super(
      mapper: ClothPriceTypeMapper(),
      dataSource: ClothPriceTypeDataDataSource()
    );

  @override
  Future<List<ClothPriceTypeEntity>> fetchData(Map<String, dynamic>? queryParameters) async {
    final List<ClothPriceTypeDTO> dataDTO = await dataSource.fetchData(queryParameters);
    final List<ClothPriceTypeEntity> dataEntity = List<ClothPriceTypeEntity>.from(
      dataDTO.map((dto) => mapper.convert<ClothPriceTypeDTO, ClothPriceTypeEntity>(dto))
    );
    return dataEntity;
  }

  @override
  Future<ClothPriceTypeEntity> storeData(ClothPriceTypePayload payload) async {
    final ClothPriceTypeDTO dataDTO = await dataSource.storeData(payload);
    final ClothPriceTypeEntity dataEntity = mapper.convert<ClothPriceTypeDTO, ClothPriceTypeEntity>(dataDTO);
    return dataEntity;
  }
  
  @override
  Future<void> deleteData(String id) async {
    await dataSource.deleteData(id);
  }
  
  @override
  Future<ClothPriceTypeEntity> updateData(String id, ClothPriceTypePayload payload) async {
    final ClothPriceTypeDTO dataDTO = await dataSource.updateData(id, payload);
    final ClothPriceTypeEntity dataEntity = mapper.convert<ClothPriceTypeDTO, ClothPriceTypeEntity>(dataDTO);

    return dataEntity;
  }
  
  @override
  Future<ClothPriceTypeEntity> fetchDetailData(String id, Map<String, dynamic>? queryParameters) async {
    final ClothPriceTypeDTO dataDTO = await dataSource.fetchDetailData(id, queryParameters);
    final ClothPriceTypeEntity dataEntity = mapper.convert<ClothPriceTypeDTO, ClothPriceTypeEntity>(dataDTO);

    return dataEntity;
  }
}