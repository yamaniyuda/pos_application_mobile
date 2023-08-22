import 'package:pos_application_mobile/data/data_source/remote_data_sources/district_data_source.dart';
import 'package:pos_application_mobile/data/mappers/district_mapper.dart';
import 'package:pos_application_mobile/domain/entities/district_entity.dart';
import 'package:pos_application_mobile/domain/repositories/repository.dart';

abstract class DistrictRepository extends Repository {
  final DistrictDataSource dataSource;
  final DistrictMapper mapper;

  DistrictRepository({
    required this.mapper,
    required this.dataSource
  });

  Future<List<DistrictEntity>> fetchData(Map<String, dynamic>? queryParameters);
}