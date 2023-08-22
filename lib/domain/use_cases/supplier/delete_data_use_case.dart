import 'package:pos_application_mobile/data/repositories/supplier_repository_impl.dart';
import 'package:pos_application_mobile/domain/repositories/supplier_repository.dart';
import 'package:pos_application_mobile/domain/use_cases/use_case.dart';

class DeleteDataUseCase extends UseCase<SupplierRepository, String> {
  DeleteDataUseCase() : super(SupplierRepositoryImpl());
  
  @override
  Future call([String? params]) async {
    await repository.deleteData(params!);
  }
}