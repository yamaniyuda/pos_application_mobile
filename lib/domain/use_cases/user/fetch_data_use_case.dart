import 'package:pos_application_mobile/data/repositories/user_repository_impl.dart';
import 'package:pos_application_mobile/domain/entities/user_entity.dart';
import 'package:pos_application_mobile/domain/repositories/user_repository.dart';
import 'package:pos_application_mobile/domain/use_cases/use_case.dart';

class FetchDataUseCase extends UseCase<UserRepository, Map<String, dynamic>> {
  FetchDataUseCase() : super(UserRepositoryImpl());

  @override
  Future<List<UserEntity>> call([Map<String, dynamic>? params]) async {
    final List<UserEntity> data = await repository.fetchData(params!);
    return data;
  }
}