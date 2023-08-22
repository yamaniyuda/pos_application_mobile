import 'package:pos_application_mobile/data/data_source/remote_data_sources/size_data_source.dart';
import 'package:pos_application_mobile/data/mappers/size_mapper.dart';
import 'package:pos_application_mobile/data/payloads/size_payload.dart';
import 'package:pos_application_mobile/domain/entities/size_entity.dart';
import 'package:pos_application_mobile/domain/repositories/repository.dart';

abstract class SizeRepository extends Repository {
  final SizeDataSource dataSource;
  final SizeMapper mapper;

  SizeRepository({
    required this.dataSource,
    required this.mapper
  });

  Future<List<SizeEntity>> fetchData(Map<String, dynamic>? queryParameters);
  Future<SizeEntity> fetchDetailData(String id, Map<String, dynamic> queryParameters);
  Future<SizeEntity> storeData(SizePayload paylaod);
  Future<SizeEntity> updateData(SizePayload params);
  Future<void> deleteData(String id); 
}