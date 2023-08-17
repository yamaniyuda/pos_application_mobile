import 'package:pos_application_mobile/data/repositories/color_repository_impl.dart';
import 'package:pos_application_mobile/domain/repositories/color_repository.dart';
import 'package:pos_application_mobile/domain/use_cases/use_case.dart';

class DeleteDataUseCase extends UseCase<ColorRepository, String> {
  DeleteDataUseCase() : super(ColorRepositoryImpl());
  
  @override
  Future call([String? params]) async {
    await repository.deleteData(params!);
  }
}