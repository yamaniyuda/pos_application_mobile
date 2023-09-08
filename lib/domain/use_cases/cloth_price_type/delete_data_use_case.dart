import 'package:pos_application_mobile/data/repositories/cloth_price_type_repository_impl.dart';
import 'package:pos_application_mobile/domain/repositories/cloth_price_type_repository.dart';
import 'package:pos_application_mobile/domain/use_cases/use_case.dart';

class DeleteDataUseCase extends UseCase<ClothPriceTypeRepository, String> {
  DeleteDataUseCase() : super(ClothPriceTypeRepositoryImpl());
  
  @override
  Future call([String? params]) async {
    await repository.deleteData(params!);
  }
}