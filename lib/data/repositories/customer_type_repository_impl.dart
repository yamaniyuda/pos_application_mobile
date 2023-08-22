
import 'package:pos_application_mobile/data/data_source/remote_data_sources/customer_type_data_source.dart';
import 'package:pos_application_mobile/data/dtos/customer_type_dto.dart';
import 'package:pos_application_mobile/data/mappers/customer_type_mapper.dart';
import 'package:pos_application_mobile/data/payloads/customer_type_payload.dart';
import 'package:pos_application_mobile/domain/entities/customer_type_entity.dart';
import 'package:pos_application_mobile/domain/repositories/customer_type_repository.dart';

class CustomerTypeRepositoryImpl extends CustomerTypeRepository {
  CustomerTypeRepositoryImpl()
    : super(
      mapper: CustomerTypeMapper(),
      dataSource: CustomerTypeDataSource()
    );

  @override
  Future<List<CustomerTypeEntity>> fetchData(Map<String, dynamic>? queryParameters) async {
    final List<CustomerTypeDTO> dataDTO = await dataSource.fetchData(queryParameters);
    final List<CustomerTypeEntity> dataEntity = List<CustomerTypeEntity>.from(
      dataDTO.map((dto) => mapper.convert<CustomerTypeDTO, CustomerTypeEntity>(dto))
    );
    return dataEntity;
  }

  @override
  Future<CustomerTypeEntity> storeData(CustomerTypePayload payload) async {
    final CustomerTypeDTO dataDTO = await dataSource.storeData(payload);
    final CustomerTypeEntity dataEntity = mapper.convert<CustomerTypeDTO, CustomerTypeEntity>(dataDTO);
    return dataEntity;
  }
  
  @override
  Future<void> deleteData(String id) async {
    await dataSource.deleteData(id);
  }
  
  @override
  Future<CustomerTypeEntity> updateData(String id, CustomerTypePayload payload) async {
    final CustomerTypeDTO dataDTO = await dataSource.updateData(id, payload);
    final CustomerTypeEntity dataEntity = mapper.convert<CustomerTypeDTO, CustomerTypeEntity>(dataDTO);

    return dataEntity;
  }
}