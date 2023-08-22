
import 'package:pos_application_mobile/data/data_source/remote_data_sources/cloth_category_data_source.dart';
import 'package:pos_application_mobile/data/dtos/cloth_categoty_dto.dart';
import 'package:pos_application_mobile/data/mappers/cloth_category_mapper.dart';
import 'package:pos_application_mobile/data/payloads/cloth_category_payload.dart';
import 'package:pos_application_mobile/domain/entities/cloth_category_entity.dart';
import 'package:pos_application_mobile/domain/repositories/cloth_category_repository.dart';

class ClothCategoryRepositoryImpl extends ClothCategoryRepository {
  ClothCategoryRepositoryImpl()
    : super(
      mapper: ClothCategoryMapper(),
      dataSource: ClothCategoryDataSource()
    );

  @override
  Future<List<ClothCategoryEntity>> fetchData(Map<String, dynamic>? queryParameters) async {
    final List<ClothCategoryDTO> dataDTO = await dataSource.fetchData(queryParameters);
    final List<ClothCategoryEntity> dataEntity = List<ClothCategoryEntity>.from(
      dataDTO.map((dto) => mapper.convert<ClothCategoryDTO, ClothCategoryEntity>(dto))
    );
    return dataEntity;
  }

  @override
  Future<ClothCategoryEntity> storeData(ClothCategoryPayload payload) async {
    final ClothCategoryDTO dataDTO = await dataSource.storeData(payload);
    final ClothCategoryEntity dataEntity = mapper.convert<ClothCategoryDTO, ClothCategoryEntity>(dataDTO);
    return dataEntity;
  }
  
  @override
  Future<void> deleteData(String id) async {
    await dataSource.deleteData(id);
  }
  
  @override
  Future<ClothCategoryEntity> updateData(ClothCategoryPayload payload) async {
    final ClothCategoryDTO dataDTO = await dataSource.updateData(payload.id, payload);
    final ClothCategoryEntity dataEntity = mapper.convert<ClothCategoryDTO, ClothCategoryEntity>(dataDTO);

    return dataEntity;
  }

  @override
  Future<ClothCategoryEntity> fetchDetailData(String id, Map<String, dynamic> queryParameters) {
    throw UnimplementedError();
  }
}