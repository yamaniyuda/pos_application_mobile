import 'package:pos_application_mobile/data/repositories/cloth_image_repository_impl.dart';
import 'package:pos_application_mobile/domain/entities/cloth_image_entity.dart';
import 'package:pos_application_mobile/domain/repositories/cloth_image_repository.dart';
import 'package:pos_application_mobile/domain/use_cases/use_case.dart';

class FetchDataUseCase extends UseCase<ClothImageRepository, Map<String, dynamic>> {
  FetchDataUseCase() : super(ClothImageRepositoryImpl());

  @override
  Future<List<ClothImageEntity>> call([Map<String, dynamic>? params]) async {
    final List<ClothImageEntity> data = await repository.fetchData(params);
    return data;
  }
}