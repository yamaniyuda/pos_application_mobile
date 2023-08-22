import 'package:pos_application_mobile/data/repositories/regency_repository_impl.dart';
import 'package:pos_application_mobile/domain/entities/regency_entity.dart';
import 'package:pos_application_mobile/domain/repositories/regency_repository.dart';
import 'package:pos_application_mobile/domain/use_cases/use_case.dart';

class FetchDataUseCase extends UseCase<RegencyRepository, Map<String, dynamic>> {
  FetchDataUseCase() : super(RegencyRepositoryImpl());

  @override
  Future<List<RegencyEntity>> call([Map<String, dynamic>? params]) async {
    final List<RegencyEntity> data = await repository.fetchData(params);
    return data;
  }
}