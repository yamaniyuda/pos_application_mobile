import 'package:pos_application_mobile/data/repositories/cloth_repository_impl.dart';
import 'package:pos_application_mobile/domain/entities/cloth_color_entity.dart';
import 'package:pos_application_mobile/domain/repositories/cloth_repository.dart';
import 'package:pos_application_mobile/domain/use_cases/use_case.dart';

class FetchBySkuUseCase extends UseCase<ClothRepository, String> {
  FetchBySkuUseCase() : super(ClothRepositoryImpl());

  @override
  Future<ClothColorEntity> call([String? params]) async {
    final ClothColorEntity data = await repository.fetchDataBySku(params!);
    return data;
  }
}