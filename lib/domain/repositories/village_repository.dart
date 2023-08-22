import 'package:pos_application_mobile/data/data_source/remote_data_sources/village_data_source.dart';
import 'package:pos_application_mobile/data/mappers/village_mapper.dart';
import 'package:pos_application_mobile/domain/entities/village_entity.dart';
import 'package:pos_application_mobile/domain/repositories/repository.dart';

abstract class VillageRepository extends Repository {
  final VillageDataSource dataSource;
  final VillageMapper mapper;

  VillageRepository({
    required this.mapper,
    required this.dataSource
  });

  Future<List<VillageEntity>> fetchData(Map<String, dynamic>? queryParameters);
}