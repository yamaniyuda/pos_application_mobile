import 'package:pos_application_mobile/data/repositories/customer_type_repository_impl.dart';
import 'package:pos_application_mobile/domain/entities/customer_type_entity.dart';
import 'package:pos_application_mobile/domain/repositories/customer_type_repository.dart';
import 'package:pos_application_mobile/domain/use_cases/use_case.dart';

class FetchDataUseCase extends UseCase<CustomerTypeRepository, Map<String, dynamic>> {
  FetchDataUseCase() : super(CustomerTypeRepositoryImpl());

  @override
  Future<List<CustomerTypeEntity>> call([Map<String, dynamic>? params]) async {
    final List<CustomerTypeEntity> data = await repository.fetchData(params);
    return data;
  }
}