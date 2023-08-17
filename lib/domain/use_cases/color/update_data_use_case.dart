import 'package:pos_application_mobile/data/payloads/color_payload.dart';
import 'package:pos_application_mobile/data/repositories/color_repository_impl.dart';
import 'package:pos_application_mobile/domain/entities/color_entity.dart';
import 'package:pos_application_mobile/domain/repositories/color_repository.dart';
import 'package:pos_application_mobile/domain/use_cases/use_case.dart';

class UpdateDataUseCase extends UseCase<ColorRepository, ColorPayload> {
  UpdateDataUseCase() : super(ColorRepositoryImpl());
  
  @override
  Future<ColorEntity> call([ColorPayload? params]) async {
    final ColorEntity data = await repository.updateData(params!.id, params);
    return data;
  }
}