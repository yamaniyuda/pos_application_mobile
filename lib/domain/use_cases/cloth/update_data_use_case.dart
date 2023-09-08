import 'package:pos_application_mobile/data/payloads/cloth_payload.dart';
import 'package:pos_application_mobile/data/repositories/cloth_repository_impl.dart';
import 'package:pos_application_mobile/domain/entities/cloth_entity.dart';
import 'package:pos_application_mobile/domain/repositories/cloth_repository.dart';
import 'package:pos_application_mobile/domain/use_cases/use_case.dart';

class UpdateDataUseCase extends UseCase<ClothRepository, ClothPayload> {
  UpdateDataUseCase() : super(ClothRepositoryImpl());
  
  @override
  Future<ClothEntity> call([ClothPayload? params]) async {
    final ClothEntity data = await repository.updateData(params!.id, params);
    return data;
  }
}