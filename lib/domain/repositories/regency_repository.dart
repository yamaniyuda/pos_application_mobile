import 'package:pos_application_mobile/data/data_source/remote_data_sources/regency_data_source.dart';
import 'package:pos_application_mobile/data/mappers/regency_mapper.dart';
import 'package:pos_application_mobile/domain/entities/regency_entity.dart';
import 'package:pos_application_mobile/domain/repositories/repository.dart';

abstract class RegencyRepository extends Repository {
  final RegencyDataSource dataSource;
  final RegencyMapper mapper;

  RegencyRepository({
    required this.mapper,
    required this.dataSource
  });

  Future<List<RegencyEntity>> fetchData(Map<String, dynamic>? queryParameters);
}