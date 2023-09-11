import 'package:pos_application_mobile/data/payloads/cloth_image_payload.dart';
import 'package:pos_application_mobile/data/repositories/cloth_image_repository_impl.dart';
import 'package:pos_application_mobile/domain/entities/cloth_image_entity.dart';
import 'package:pos_application_mobile/domain/repositories/cloth_image_repository.dart';
import 'package:pos_application_mobile/domain/use_cases/use_case.dart';

class StoreDataUseCase extends UseCase<ClothImageRepository, ClothImagePayload> {
  StoreDataUseCase() : super(ClothImageRepositoryImpl());

  @override
  Future call([ClothImagePayload? params]) async {
    final ClothImageEntity data = await repository.storeData(params!);
    return data;
  }
}