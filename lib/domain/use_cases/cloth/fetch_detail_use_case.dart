import 'package:pos_application_mobile/data/repositories/cloth_repository_impl.dart';
import 'package:pos_application_mobile/domain/entities/cloth_entity.dart';
import 'package:pos_application_mobile/domain/repositories/cloth_repository.dart';
import 'package:pos_application_mobile/domain/use_cases/use_case.dart';

class FetchDetailDataUseCase extends UseCase<ClothRepository, String> {
  FetchDetailDataUseCase() : super(ClothRepositoryImpl());

  @override
  Future<ClothEntity> call([String? params]) async {
    final ClothEntity data = await repository.fetchDetailData(params!, {});
    return data;
  }
}