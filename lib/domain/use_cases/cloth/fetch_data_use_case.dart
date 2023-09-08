import 'package:pos_application_mobile/data/repositories/cloth_repository_impl.dart';
import 'package:pos_application_mobile/domain/entities/cloth_entity.dart';
import 'package:pos_application_mobile/domain/repositories/cloth_repository.dart';
import 'package:pos_application_mobile/domain/use_cases/use_case.dart';

class FetchDataUseCase extends UseCase<ClothRepository, Map<String, dynamic>> {
  FetchDataUseCase() : super(ClothRepositoryImpl());

  @override
  Future<List<ClothEntity>> call([Map<String, dynamic>? params]) async {
    final List<ClothEntity> data = await repository.fetchData(params);
    return data;
  }
}