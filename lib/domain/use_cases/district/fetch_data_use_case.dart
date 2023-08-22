import 'package:pos_application_mobile/data/repositories/district_repository_impl.dart';
import 'package:pos_application_mobile/domain/entities/district_entity.dart';
import 'package:pos_application_mobile/domain/repositories/district_repository.dart';
import 'package:pos_application_mobile/domain/use_cases/use_case.dart';

class FetchDataUseCase extends UseCase<DistrictRepository, Map<String, dynamic>> {
  FetchDataUseCase() : super(DistrictRepositoryImpl());

  @override
  Future<List<DistrictEntity>> call([Map<String, dynamic>? params]) async {
    final List<DistrictEntity> data = await repository.fetchData(params);
    return data;
  }
}