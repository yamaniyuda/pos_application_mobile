import 'package:pos_application_mobile/data/repositories/customer_repository_impl.dart';
import 'package:pos_application_mobile/domain/entities/customer_entity.dart';
import 'package:pos_application_mobile/domain/repositories/customer_repository.dart';
import 'package:pos_application_mobile/domain/use_cases/use_case.dart';

class FetchDataUseCase extends UseCase<CustomerRepository, Map<String, dynamic>> {
  FetchDataUseCase() : super(CustomerRepositoryImpl());

  @override
  Future<List<CustomerEntity>> call([Map<String, dynamic>? params]) async {
    final List<CustomerEntity> data = await repository.fetchData(params);
    return data;
  }
}