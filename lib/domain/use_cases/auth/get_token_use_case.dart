import 'package:pos_application_mobile/data/repositories/auth_repository_impl.dart';
import 'package:pos_application_mobile/domain/repositories/auth_repository.dart';
import 'package:pos_application_mobile/domain/use_cases/use_case.dart';

class GetTokenUseCase extends UseCase<AuthRepository, String> {
  GetTokenUseCase() : super(AuthRepositoryImpl());

  @override
  Future<String> call([String? params]) async {
    final String data = await repository.getToken();
    return data;
  }
}