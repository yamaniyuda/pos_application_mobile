
import 'package:pos_application_mobile/data/data_source/remote_data_sources/supplier_data_source.dart';
import 'package:pos_application_mobile/data/dtos/supplier_dto.dart';
import 'package:pos_application_mobile/data/mappers/supplier_mapper.dart';
import 'package:pos_application_mobile/data/payloads/supplier_payload.dart';
import 'package:pos_application_mobile/domain/entities/supplier_entity.dart';
import 'package:pos_application_mobile/domain/repositories/supplier_repository.dart';

class SupplierRepositoryImpl extends SupplierRepository {
  SupplierRepositoryImpl()
    : super(
      mapper: SupplierMapper(),
      dataSource: SupplierDataSource()
    );

  @override
  Future<List<SupplierEntity>> fetchData(Map<String, dynamic>? queryParameters) async {
    final List<SupplierDTO> dataDTO = await dataSource.fetchData(queryParameters);
    final List<SupplierEntity> dataEntity = List<SupplierEntity>.from(
      dataDTO.map((dto) => mapper.convert<SupplierDTO, SupplierEntity>(dto))
    );
    return dataEntity;
  }

  @override
  Future<SupplierEntity> storeData(SupplierPayload payload) async {
    final SupplierDTO dataDTO = await dataSource.storeData(payload);
    final SupplierEntity dataEntity = mapper.convert<SupplierDTO, SupplierEntity>(dataDTO);
    return dataEntity;
  }
  
  @override
  Future<void> deleteData(String id) async {
    await dataSource.deleteData(id);
  }
  
  @override
  Future<SupplierEntity> updateData(SupplierPayload payload) async {
    final SupplierDTO dataDTO = await dataSource.updateData(payload.id, payload);
    final SupplierEntity dataEntity = mapper.convert<SupplierDTO, SupplierEntity>(dataDTO);

    return dataEntity;
  }

  @override
  Future<SupplierEntity> fetchDetailData(String id, Map<String, dynamic> queryParameters) {
    throw UnimplementedError();
  }
}