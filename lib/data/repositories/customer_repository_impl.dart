
import 'package:pos_application_mobile/data/data_source/remote_data_sources/customer_data_source.dart';
import 'package:pos_application_mobile/data/dtos/customer_dto.dart';
import 'package:pos_application_mobile/data/mappers/customer_mapper.dart';
import 'package:pos_application_mobile/data/payloads/customer_payload.dart';
import 'package:pos_application_mobile/domain/entities/customer_entity.dart';
import 'package:pos_application_mobile/domain/repositories/customer_repository.dart';

class CustomerRepositoryImpl extends CustomerRepository {
  CustomerRepositoryImpl()
    : super(
      mapper: CustomerMapper(),
      dataSource: CustomerDataSource()
    );

  @override
  Future<List<CustomerEntity>> fetchData(Map<String, dynamic>? queryParameters) async {
    final List<CustomerDTO> dataDTO = await dataSource.fetchData(queryParameters);
    final List<CustomerEntity> dataEntity = List<CustomerEntity>.from(
      dataDTO.map((dto) => mapper.convert<CustomerDTO, CustomerEntity>(dto))
    );
    return dataEntity;
  }

  @override
  Future<CustomerEntity> storeData(CustomerPayload payload) async {
    final CustomerDTO dataDTO = await dataSource.storeData(payload);
    final CustomerEntity dataEntity = mapper.convert<CustomerDTO, CustomerEntity>(dataDTO);
    return dataEntity;
  }
  
  @override
  Future<void> deleteData(String id) async {
    await dataSource.deleteData(id);
  }
  
  @override
  Future<CustomerEntity> updateData(String id, CustomerPayload payload) async {
    final CustomerDTO dataDTO = await dataSource.updateData(id, payload);
    final CustomerEntity dataEntity = mapper.convert<CustomerDTO, CustomerEntity>(dataDTO);

    return dataEntity;
  }
  
  @override
  Future<CustomerEntity> fetchDetailData(String id, Map<String, dynamic>? queryParameters) async {
    final CustomerDTO dataDTO = await dataSource.fetchDetailData(id, queryParameters);
    final CustomerEntity dataEntity = mapper.convert<CustomerDTO, CustomerEntity>(dataDTO);

    return dataEntity;
  }
}