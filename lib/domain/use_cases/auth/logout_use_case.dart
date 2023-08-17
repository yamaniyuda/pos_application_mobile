import 'package:pos_application_mobile/data/repositories/auth_repository_impl.dart';
import 'package:pos_application_mobile/domain/repositories/auth_repository.dart';
import 'package:pos_application_mobile/domain/use_cases/use_case.dart';

class LogoutUseCase extends UseCase<AuthRepository, String> {
  LogoutUseCase() : super(AuthRepositoryImpl());
  
  @override
  Future<void> call([String? params]) async {
    await repository.logout();
  }
}