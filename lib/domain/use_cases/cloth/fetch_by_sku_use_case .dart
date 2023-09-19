import 'package:pos_application_mobile/data/repositories/cloth_repository_impl.dart';
import 'package:pos_application_mobile/domain/entities/cloth_color_entity.dart';
import 'package:pos_application_mobile/domain/repositories/cloth_repository.dart';
import 'package:pos_application_mobile/domain/use_cases/use_case.dart';

class FetchBySkuUseCaseParams {
  final String sku;
  final String customerCategoryId;

  FetchBySkuUseCaseParams({
    required this.customerCategoryId,
    required this.sku
  });
}

class FetchBySkuUseCase extends UseCase<ClothRepository, FetchBySkuUseCaseParams> {
  FetchBySkuUseCase() : super(ClothRepositoryImpl());

  @override
  Future<ClothColorEntity> call([FetchBySkuUseCaseParams? params]) async {
    final ClothColorEntity data = await repository.fetchDataBySku(params!.sku, params.customerCategoryId);
    return data;
  }
}