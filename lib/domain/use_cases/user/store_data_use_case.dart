import 'package:pos_application_mobile/data/payloads/user_payload.dart';
import 'package:pos_application_mobile/data/repositories/user_repository_impl.dart';
import 'package:pos_application_mobile/domain/entities/user_entity.dart';
import 'package:pos_application_mobile/domain/repositories/user_repository.dart';
import 'package:pos_application_mobile/domain/use_cases/use_case.dart';

class StoreDataUseCase extends UseCase<UserRepository, UserPaylaod> {
  StoreDataUseCase() : super(UserRepositoryImpl());

  @override
  Future<UserEntity> call([UserPaylaod? params]) async {
    final UserEntity data = await repository.storeData(params!);
    return data;
  }
}
