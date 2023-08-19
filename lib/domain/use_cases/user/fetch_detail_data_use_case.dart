import 'package:pos_application_mobile/data/repositories/user_repository_impl.dart';
import 'package:pos_application_mobile/domain/entities/user_entity.dart';
import 'package:pos_application_mobile/domain/repositories/user_repository.dart';
import 'package:pos_application_mobile/domain/use_cases/use_case.dart';

class FetchDetailDataUseCase extends UseCase<UserRepository, ParamTuple<String, Map<String, dynamic>?>> {
  FetchDetailDataUseCase() : super(UserRepositoryImpl());
  
  @override
  Future<UserEntity> call([ParamTuple? params]) async {
    final UserEntity data = await repository.fetchDetailData(params?.item1!, params?.item2);
    return data;
  }
}