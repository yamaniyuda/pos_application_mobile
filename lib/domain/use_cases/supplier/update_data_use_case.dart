import 'package:pos_application_mobile/data/payloads/supplier_payload.dart';
import 'package:pos_application_mobile/data/repositories/supplier_repository_impl.dart';
import 'package:pos_application_mobile/domain/entities/supplier_entity.dart';
import 'package:pos_application_mobile/domain/repositories/supplier_repository.dart';
import 'package:pos_application_mobile/domain/use_cases/use_case.dart';

class UpdateDataUseCase extends UseCase<SupplierRepository, SupplierPayload> {
  UpdateDataUseCase() : super(SupplierRepositoryImpl());
  
  @override
  Future<SupplierEntity> call([SupplierPayload? params]) async {
    final SupplierEntity data = await repository.updateData(params!);
    return data;
  }
}