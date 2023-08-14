import 'package:pos_application_mobile/domain/use_cases/auth/me_use_case.dart';
import 'package:pos_application_mobile/domain/use_cases/auth/sign_in_use_case.dart';

class DIContainer {
  static final DIContainer _instance = DIContainer._internal();

  factory DIContainer() {
    return _instance;
  }

  DIContainer._internal();

  final MeUseCase meUseCase = MeUseCase();
  final SignInUseCase signInUseCase = SignInUseCase();
}