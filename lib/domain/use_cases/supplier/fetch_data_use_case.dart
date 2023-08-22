import 'package:pos_application_mobile/data/repositories/supplier_repository_impl.dart';
import 'package:pos_application_mobile/domain/entities/supplier_entity.dart';
import 'package:pos_application_mobile/domain/repositories/supplier_repository.dart';
import 'package:pos_application_mobile/domain/use_cases/use_case.dart';

class FetchDataUseCase extends UseCase<SupplierRepository, Map<String, dynamic>> {
  FetchDataUseCase() : super(SupplierRepositoryImpl());

  @override
  Future<List<SupplierEntity>> call([Map<String, dynamic>? params]) async {
    final List<SupplierEntity> data = await repository.fetchData(params);
    return data;
  }
}