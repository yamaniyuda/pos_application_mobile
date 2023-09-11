import 'package:pos_application_mobile/data/repositories/cloth_image_repository_impl.dart';
import 'package:pos_application_mobile/domain/repositories/cloth_image_repository.dart';
import 'package:pos_application_mobile/domain/use_cases/use_case.dart';

class DeleteDataUseCase extends UseCase<ClothImageRepository, String> {
  DeleteDataUseCase() : super(ClothImageRepositoryImpl());
  
  @override
  Future call([String? params]) async {
    await repository.deleteData(params!);
  }
}