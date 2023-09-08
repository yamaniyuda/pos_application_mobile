import 'package:pos_application_mobile/data/repositories/cloth_price_type_repository_impl.dart';
import 'package:pos_application_mobile/domain/entities/cloth_price_type_entity.dart';
import 'package:pos_application_mobile/domain/repositories/cloth_price_type_repository.dart';
import 'package:pos_application_mobile/domain/use_cases/use_case.dart';

class FetchDataUseCase extends UseCase<ClothPriceTypeRepository, Map<String, dynamic>> {
  FetchDataUseCase() : super(ClothPriceTypeRepositoryImpl());

  @override
  Future<List<ClothPriceTypeEntity>> call([Map<String, dynamic>? params]) async {
    final List<ClothPriceTypeEntity> data = await repository.fetchData(params);
    return data;
  }
}