import 'package:pos_application_mobile/data/payloads/cloth_payload.dart';
import 'package:pos_application_mobile/data/repositories/cloth_repository_impl.dart';
import 'package:pos_application_mobile/domain/repositories/cloth_repository.dart';
import 'package:pos_application_mobile/domain/use_cases/use_case.dart';

class StoreDataUseCase extends UseCase<ClothRepository, ClothPayload> {
  StoreDataUseCase() : super(ClothRepositoryImpl());

  @override
  Future call([ClothPayload? params]) async {
    final String data = await repository.storeData(params!);
    return data;
  }
}