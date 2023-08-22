import 'package:pos_application_mobile/data/repositories/cloth_category_repository_impl.dart';
import 'package:pos_application_mobile/domain/repositories/cloth_category_repository.dart';
import 'package:pos_application_mobile/domain/use_cases/use_case.dart';

class DeleteDataUseCase extends UseCase<ClothCategoryRepository, String> {
  DeleteDataUseCase() : super(ClothCategoryRepositoryImpl());
  
  @override
  Future call([String? params]) async {
    await repository.deleteData(params!);
  }
}