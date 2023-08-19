import 'package:pos_application_mobile/data/repositories/user_repository_impl.dart';
import 'package:pos_application_mobile/domain/repositories/user_repository.dart';
import 'package:pos_application_mobile/domain/use_cases/use_case.dart';

class DeleteDataUseCase extends UseCase<UserRepository, String> {
  DeleteDataUseCase() : super(UserRepositoryImpl());

  @override
  Future call([String? params]) async {
    await repository.deleteData(params!);
  }
}
