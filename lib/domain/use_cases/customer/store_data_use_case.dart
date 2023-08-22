import 'package:pos_application_mobile/data/payloads/customer_payload.dart';
import 'package:pos_application_mobile/data/repositories/customer_repository_impl.dart';
import 'package:pos_application_mobile/domain/entities/customer_entity.dart';
import 'package:pos_application_mobile/domain/repositories/customer_repository.dart';
import 'package:pos_application_mobile/domain/use_cases/use_case.dart';

class StoreDataUseCase extends UseCase<CustomerRepository, CustomerPayload> {
  StoreDataUseCase() : super(CustomerRepositoryImpl());

  @override
  Future call([CustomerPayload? params]) async {
    final CustomerEntity data = await repository.storeData(params!);
    return data;
  }
}