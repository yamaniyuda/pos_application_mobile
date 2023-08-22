import 'package:pos_application_mobile/data/data_source/remote_data_sources/supplier_data_source.dart';
import 'package:pos_application_mobile/data/mappers/supplier_mapper.dart';
import 'package:pos_application_mobile/data/payloads/supplier_payload.dart';
import 'package:pos_application_mobile/domain/entities/supplier_entity.dart';
import 'package:pos_application_mobile/domain/repositories/repository.dart';

abstract class SupplierRepository extends Repository {
  final SupplierDataSource dataSource;
  final SupplierMapper mapper;

  SupplierRepository({
    required this.dataSource,
    required this.mapper
  });

  Future<List<SupplierEntity>> fetchData(Map<String, dynamic>? queryParameters);
  Future<SupplierEntity> fetchDetailData(String id, Map<String, dynamic> queryParameters);
  Future<SupplierEntity> storeData(SupplierPayload paylaod);
  Future<SupplierEntity> updateData(SupplierPayload params);
  Future<void> deleteData(String id); 
}