import 'package:pos_application_mobile/data/payloads/cloth_color_payload.dart';
import 'package:pos_application_mobile/data/repositories/cloth_repository_impl.dart';
import 'package:pos_application_mobile/domain/repositories/cloth_repository.dart';
import 'package:pos_application_mobile/domain/use_cases/use_case.dart';

class AddClothSizeUseCaseParams {
  AddClothSizeUseCaseParams({
    required this.id,
    required this.colorId,
    required this.payload
  });

  final String id;
  final String colorId;
  final ClothColorPayload payload;
}

class AddClothSizeUseCase extends UseCase<ClothRepository, AddClothSizeUseCaseParams> {
  AddClothSizeUseCase() : super(ClothRepositoryImpl());

  @override
  Future<void> call([AddClothSizeUseCaseParams? params]) async {
    await repository.addClothSize(params!.id, params.colorId, params.payload);
  }
}