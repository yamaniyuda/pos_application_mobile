import 'package:pos_application_mobile/data/data_source/remote_data_sources/provincy_data_source.dart';
import 'package:pos_application_mobile/data/mappers/provincy_mapper.dart';
import 'package:pos_application_mobile/domain/entities/provincy_entity.dart';
import 'package:pos_application_mobile/domain/repositories/repository.dart';

abstract class ProvincyRepository extends Repository {
  final ProvincyDataSource dataSource;
  final ProvincyMapper mapper;

  ProvincyRepository({
    required this.mapper,
    required this.dataSource
  });

  Future<List<ProvincyEntity>> fetchData(Map<String, dynamic>? queryParameters);
}