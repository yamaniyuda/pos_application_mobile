import 'package:pos_application_mobile/data/repositories/auth_repository_impl.dart';
import 'package:pos_application_mobile/domain/entities/user_entity.dart';
import 'package:pos_application_mobile/domain/repositories/auth_repository.dart';
import 'package:pos_application_mobile/domain/use_cases/use_case.dart';

class MeUseCase extends UseCase<AuthRepository, String> {
  MeUseCase() : super(AuthRepositoryImpl());

  @override
  Future<UserEntity?> call([String? params]) async {
    final UserEntity? data = await repository.me();
    return data;
  }
}