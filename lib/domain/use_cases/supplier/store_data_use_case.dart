import 'package:pos_application_mobile/data/payloads/supplier_payload.dart';
import 'package:pos_application_mobile/data/repositories/supplier_repository_impl.dart';
import 'package:pos_application_mobile/domain/entities/supplier_entity.dart';
import 'package:pos_application_mobile/domain/repositories/supplier_repository.dart';
import 'package:pos_application_mobile/domain/use_cases/use_case.dart';

class StoreDataUseCase extends UseCase<SupplierRepository, SupplierPayload> {
  StoreDataUseCase() : super(SupplierRepositoryImpl());

  @override
  Future call([SupplierPayload? params]) async {
    final SupplierEntity data = await repository.storeData(params!);
    return data;
  }
}