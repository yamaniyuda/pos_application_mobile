import 'package:pos_application_mobile/data/repositories/cloth_repository_impl.dart';
import 'package:pos_application_mobile/domain/repositories/cloth_repository.dart';
import 'package:pos_application_mobile/domain/use_cases/use_case.dart';

class DeleteDataUseCase extends UseCase<ClothRepository, String> {
  DeleteDataUseCase() : super(ClothRepositoryImpl());
  
  @override
  Future call([String? params]) async {
    await repository.deleteData(params!);
  }
}