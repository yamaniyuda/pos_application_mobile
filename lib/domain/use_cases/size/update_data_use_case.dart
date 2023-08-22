import 'package:pos_application_mobile/data/payloads/size_payload.dart';
import 'package:pos_application_mobile/data/repositories/size_repository_impl.dart';
import 'package:pos_application_mobile/domain/entities/size_entity.dart';
import 'package:pos_application_mobile/domain/repositories/size_repository.dart';
import 'package:pos_application_mobile/domain/use_cases/use_case.dart';

class UpdateDataUseCase extends UseCase<SizeRepository, SizePayload> {
  UpdateDataUseCase() : super(SizeRepositoryImpl());
  
  @override
  Future<SizeEntity> call([SizePayload? params]) async {
    final SizeEntity data = await repository.updateData(params!);
    return data;
  }
}