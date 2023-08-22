import 'package:pos_application_mobile/data/repositories/customer_repository_impl.dart';
import 'package:pos_application_mobile/domain/repositories/customer_repository.dart';
import 'package:pos_application_mobile/domain/use_cases/use_case.dart';

class DeleteDataUseCase extends UseCase<CustomerRepository, String> {
  DeleteDataUseCase() : super(CustomerRepositoryImpl());
  
  @override
  Future call([String? params]) async {
    await repository.deleteData(params!);
  }
}