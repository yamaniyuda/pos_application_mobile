import 'package:pos_application_mobile/data/repositories/village_repository_impl.dart';
import 'package:pos_application_mobile/domain/entities/village_entity.dart';
import 'package:pos_application_mobile/domain/repositories/village_repository.dart';
import 'package:pos_application_mobile/domain/use_cases/use_case.dart';

class FetchDataUseCase extends UseCase<VillageRepository, Map<String, dynamic>> {
  FetchDataUseCase() : super(VillageRepositoryImpl());

  @override
  Future<List<VillageEntity>> call([Map<String, dynamic>? params]) async {
    final List<VillageEntity> data = await repository.fetchData(params);
    return data;
  }
}