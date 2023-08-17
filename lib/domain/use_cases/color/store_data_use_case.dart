import 'package:pos_application_mobile/data/payloads/color_payload.dart';
import 'package:pos_application_mobile/data/repositories/color_repository_impl.dart';
import 'package:pos_application_mobile/domain/entities/color_entity.dart';
import 'package:pos_application_mobile/domain/repositories/color_repository.dart';
import 'package:pos_application_mobile/domain/use_cases/use_case.dart';

class StoreDataUseCase extends UseCase<ColorRepository, ColorPayload> {
  StoreDataUseCase() : super(ColorRepositoryImpl());

  @override
  Future call([ColorPayload? params]) async {
    final ColorEntity data = await repository.storeData(params!);
    return data;
  }
}