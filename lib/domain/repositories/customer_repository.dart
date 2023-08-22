import 'package:pos_application_mobile/data/data_source/remote_data_sources/customer_data_source.dart';
import 'package:pos_application_mobile/data/mappers/customer_mapper.dart';
import 'package:pos_application_mobile/data/payloads/customer_payload.dart';
import 'package:pos_application_mobile/domain/entities/customer_entity.dart';
import 'package:pos_application_mobile/domain/repositories/repository.dart';

abstract class CustomerRepository extends Repository {
  final CustomerDataSource dataSource;
  final CustomerMapper mapper;

  CustomerRepository({
    required this.mapper,
    required this.dataSource
  });

  Future<List<CustomerEntity>> fetchData(Map<String, dynamic>? queryParameters);
  Future<CustomerEntity> fetchDetailData(String id, Map<String, dynamic>? queryParameters);
  Future<CustomerEntity> storeData(CustomerPayload payload);
  Future<void> deleteData(String id);
  Future<CustomerEntity>  updateData(String id, CustomerPayload payload);
} 