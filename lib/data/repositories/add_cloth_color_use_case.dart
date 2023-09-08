import 'package:pos_application_mobile/data/payloads/cloth_payload.dart';
import 'package:pos_application_mobile/data/repositories/cloth_repository_impl.dart';
import 'package:pos_application_mobile/domain/repositories/cloth_repository.dart';
import 'package:pos_application_mobile/domain/use_cases/use_case.dart';

class AddClothColorParams {
  AddClothColorParams({
    required this.id,
    required this.payload
  });

  final String id;
  final ClothPayload payload;
}

class AddClothColorUseCase extends UseCase<ClothRepository, AddClothColorParams> {
  AddClothColorUseCase() : super(ClothRepositoryImpl());

  @override
  Future<void> call([AddClothColorParams? params]) async {
    await repository.addClothColor(params!.id, params.payload);
  }
}