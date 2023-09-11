
import 'package:pos_application_mobile/data/data_source/remote_data_sources/cloth_image_data_source.dart';
import 'package:pos_application_mobile/data/dtos/cloth_image_dto.dart';
import 'package:pos_application_mobile/data/mappers/cloth_image_mapper.dart';
import 'package:pos_application_mobile/data/payloads/cloth_image_payload.dart';
import 'package:pos_application_mobile/domain/entities/cloth_image_entity.dart';
import 'package:pos_application_mobile/domain/repositories/cloth_image_repository.dart';

class ClothImageRepositoryImpl extends ClothImageRepository {
  ClothImageRepositoryImpl()
    : super(
      mapper: ClothImageMapper(),
      dataSource: ClothImageDataSource()
    );

  @override
  Future<List<ClothImageEntity>> fetchData(Map<String, dynamic>? queryParameters) async {
    final List<ClothImageDTO> dataDTO = await dataSource.fetchData(queryParameters);
    final List<ClothImageEntity> dataEntity = List<ClothImageEntity>.from(
      dataDTO.map((dto) => mapper.convert<ClothImageDTO, ClothImageEntity>(dto))
    );
    return dataEntity;
  }

  @override
  Future<ClothImageEntity> storeData(ClothImagePayload paylaod) async {
    final ClothImageDTO dataDTO = await dataSource.storeData(paylaod);
    final ClothImageEntity dataEntity = mapper.convert<ClothImageDTO, ClothImageEntity>(dataDTO);
    return dataEntity;
  }
  
  @override
  Future<void> deleteData(String id) async {
    await dataSource.deleteData(id);
  }
  
  @override
  Future<ClothImageEntity> updateData(ClothImagePayload payload) async {
    final ClothImageDTO dataDTO = await dataSource.updateData(payload.id, payload);
    final ClothImageEntity dataEntity = mapper.convert<ClothImageDTO, ClothImageEntity>(dataDTO);

    return dataEntity;
  }

  @override
  Future<ClothImageEntity> fetchDetailData(String id, Map<String, dynamic> queryParameters) {
    throw UnimplementedError();
  }
}