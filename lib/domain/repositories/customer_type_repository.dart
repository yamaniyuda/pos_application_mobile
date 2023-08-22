import 'package:pos_application_mobile/data/data_source/remote_data_sources/customer_type_data_source.dart';
import 'package:pos_application_mobile/data/mappers/customer_type_mapper.dart';
import 'package:pos_application_mobile/data/payloads/customer_type_payload.dart';
import 'package:pos_application_mobile/domain/entities/customer_type_entity.dart';
import 'package:pos_application_mobile/domain/repositories/repository.dart';

abstract class CustomerTypeRepository extends Repository {
  final CustomerTypeDataSource dataSource;
  final CustomerTypeMapper mapper;

  CustomerTypeRepository({
    required this.mapper,
    required this.dataSource
  });

  Future<List<CustomerTypeEntity>> fetchData(Map<String, dynamic>? queryParameters);
  Future<CustomerTypeEntity> storeData(CustomerTypePayload payload);
  Future<void> deleteData(String id);
  Future<CustomerTypeEntity>  updateData(String id, CustomerTypePayload payload);
}