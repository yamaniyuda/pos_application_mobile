import 'package:pos_application_mobile/data/repositories/size_repository_impl.dart';
import 'package:pos_application_mobile/domain/entities/size_entity.dart';
import 'package:pos_application_mobile/domain/repositories/size_repository.dart';
import 'package:pos_application_mobile/domain/use_cases/use_case.dart';

class FetchDataUseCase extends UseCase<SizeRepository, Map<String, dynamic>> {
  FetchDataUseCase() : super(SizeRepositoryImpl());

  @override
  Future<List<SizeEntity>> call([Map<String, dynamic>? params]) async {
    final List<SizeEntity> data = await repository.fetchData(params);
    return data;
  }
}