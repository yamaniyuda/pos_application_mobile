import 'package:pos_application_mobile/data/repositories/size_repository_impl.dart';
import 'package:pos_application_mobile/domain/repositories/size_repository.dart';
import 'package:pos_application_mobile/domain/use_cases/use_case.dart';

class DeleteDataUseCase extends UseCase<SizeRepository, String> {
  DeleteDataUseCase() : super(SizeRepositoryImpl());
  
  @override
  Future call([String? params]) async {
    await repository.deleteData(params!);
  }
}