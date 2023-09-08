import 'package:pos_application_mobile/data/payloads/cloth_price_type_payload.dart';
import 'package:pos_application_mobile/data/repositories/cloth_price_type_repository_impl.dart';
import 'package:pos_application_mobile/domain/entities/cloth_price_type_entity.dart';
import 'package:pos_application_mobile/domain/repositories/cloth_price_type_repository.dart';
import 'package:pos_application_mobile/domain/use_cases/use_case.dart';

class UpdateDataUseCase extends UseCase<ClothPriceTypeRepository, ClothPriceTypePayload> {
  UpdateDataUseCase() : super(ClothPriceTypeRepositoryImpl());
  
  @override
  Future<ClothPriceTypeEntity> call([ClothPriceTypePayload? params]) async {
    final ClothPriceTypeEntity data = await repository.updateData(params!.id, params);
    return data;
  }
}