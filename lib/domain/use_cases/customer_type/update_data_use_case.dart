import 'package:pos_application_mobile/data/payloads/customer_type_payload.dart';
import 'package:pos_application_mobile/data/repositories/customer_type_repository_impl.dart';
import 'package:pos_application_mobile/domain/entities/customer_type_entity.dart';
import 'package:pos_application_mobile/domain/repositories/customer_type_repository.dart';
import 'package:pos_application_mobile/domain/use_cases/use_case.dart';

class UpdateDataUseCase extends UseCase<CustomerTypeRepository, CustomerTypePayload> {
  UpdateDataUseCase() : super(CustomerTypeRepositoryImpl());
  
  @override
  Future<CustomerTypeEntity> call([CustomerTypePayload? params]) async {
    final CustomerTypeEntity data = await repository.updateData(params!.id, params);
    return data;
  }
}