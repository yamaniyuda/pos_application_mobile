import 'package:pos_application_mobile/data/payloads/cloth_category_payload.dart';
import 'package:pos_application_mobile/data/repositories/cloth_category_repository_impl.dart';
import 'package:pos_application_mobile/domain/entities/cloth_category_entity.dart';
import 'package:pos_application_mobile/domain/repositories/cloth_category_repository.dart';
import 'package:pos_application_mobile/domain/use_cases/use_case.dart';

class StoreDataUseCase extends UseCase<ClothCategoryRepository, ClothCategoryPayload> {
  StoreDataUseCase() : super(ClothCategoryRepositoryImpl());

  @override
  Future call([ClothCategoryPayload? params]) async {
    final ClothCategoryEntity data = await repository.storeData(params!);
    return data;
  }
}