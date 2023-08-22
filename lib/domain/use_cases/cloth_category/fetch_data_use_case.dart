import 'package:pos_application_mobile/data/repositories/cloth_category_repository_impl.dart';
import 'package:pos_application_mobile/domain/entities/cloth_category_entity.dart';
import 'package:pos_application_mobile/domain/repositories/cloth_category_repository.dart';
import 'package:pos_application_mobile/domain/use_cases/use_case.dart';

class FetchDataUseCase extends UseCase<ClothCategoryRepository, Map<String, dynamic>> {
  FetchDataUseCase() : super(ClothCategoryRepositoryImpl());

  @override
  Future<List<ClothCategoryEntity>> call([Map<String, dynamic>? params]) async {
    final List<ClothCategoryEntity> data = await repository.fetchData(params);
    return data;
  }
}