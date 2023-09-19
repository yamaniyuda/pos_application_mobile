
import 'package:pos_application_mobile/data/data_source/remote_data_sources/cloth_data_source.dart';
import 'package:pos_application_mobile/data/dtos/cloth_color_dto.dart';
import 'package:pos_application_mobile/data/dtos/cloth_dto.dart';
import 'package:pos_application_mobile/data/mappers/cloth_color_mapper.dart';
import 'package:pos_application_mobile/data/mappers/cloth_mapper.dart';
import 'package:pos_application_mobile/data/payloads/cloth_color_payload.dart';
import 'package:pos_application_mobile/data/payloads/cloth_payload.dart';
import 'package:pos_application_mobile/domain/entities/cloth_color_entity.dart';
import 'package:pos_application_mobile/domain/entities/cloth_entity.dart';
import 'package:pos_application_mobile/domain/repositories/cloth_repository.dart';

class ClothRepositoryImpl extends ClothRepository {
  ClothRepositoryImpl()
    : super(
      mapper: ClothMapper(),
      dataSource: ClothDataSource()
    );

  final mapperCloth = ClothColorMapper();

  @override
  Future<List<ClothEntity>> fetchData(Map<String, dynamic>? queryParameters) async {
    final List<ClothDTO> dataDTO = await dataSource.fetchData(queryParameters);
    final List<ClothEntity> dataEntity = List<ClothEntity>.from(
      dataDTO.map((dto) => mapper.convert<ClothDTO, ClothEntity>(dto))
    );
    return dataEntity;
  }

  @override
  Future<String> storeData(ClothPayload payload) async {
    final String respone = await dataSource.storeData(payload);
    return respone;
  }
  
  @override
  Future<void> deleteData(String id) async {
    await dataSource.deleteData(id);
  }
  
  @override
  Future<ClothEntity> updateData(String id, ClothPayload payload) async {
    final ClothDTO dataDTO = await dataSource.updateData(id, payload);
    final ClothEntity dataEntity = mapper.convert<ClothDTO, ClothEntity>(dataDTO);

    return dataEntity;
  }
  
  @override
  Future<ClothEntity> fetchDetailData(String id, Map<String, dynamic>? queryParameters) async {
    final ClothDTO dataDTO = await dataSource.fetchDetailData(id, queryParameters);
    final ClothEntity dataEntity = mapper.convert<ClothDTO, ClothEntity>(dataDTO);

    return dataEntity;
  }

  @override
  Future<void> addClothColor(String id, ClothPayload payload) async {
    await dataSource.addClothColor(id, payload);
  }
  
  @override
  Future<void> addClothSize(String id, String colorId, ClothColorPayload payload) async {
    await dataSource.addClothSize(id, colorId, payload);
  }
  
  @override
  Future<ClothColorEntity> fetchDataBySku(String sku, String customerCategoryId) async {
    final ClothColorDTO dataDTO = await dataSource.fetchDataBySku(sku, customerCategoryId);
    final ClothColorEntity dataEntity = mapperCloth.convert<ClothColorDTO, ClothColorEntity>(dataDTO);

    return dataEntity;
  }
}