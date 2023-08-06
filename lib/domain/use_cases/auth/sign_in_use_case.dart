import 'package:pos_application_mobile/data/payloads/sign_in_payload.dart';
import 'package:pos_application_mobile/data/repositories/auth_repository_impl.dart';
import 'package:pos_application_mobile/domain/repositories/auth_repository.dart';
import 'package:pos_application_mobile/domain/use_cases/use_case.dart';

class SignInUseCase extends UseCase<AuthRepository, SignInPayload> {
  SignInUseCase() : super(AuthRepositoryImpl());

  @override
  Future<bool> call([SignInPayload? params]) async {
    final bool result = await repository.signIn(params!);
    return result;
  }
}