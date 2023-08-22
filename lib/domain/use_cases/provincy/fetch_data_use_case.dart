import 'package:pos_application_mobile/data/repositories/provincy_repository_impl.dart';
import 'package:pos_application_mobile/domain/entities/provincy_entity.dart';
import 'package:pos_application_mobile/domain/repositories/provindy_repository.dart';
import 'package:pos_application_mobile/domain/use_cases/use_case.dart';

class FetchDataUseCase extends UseCase<ProvincyRepository, Map<String, dynamic>> {
  FetchDataUseCase() : super(ProvincyRepositoryImpl());

  @override
  Future<List<ProvincyEntity>> call([Map<String, dynamic>? params]) async {
    final List<ProvincyEntity> data = await repository.fetchData(params);
    return data;
  }
}