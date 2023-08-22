import 'package:pos_application_mobile/data/payloads/size_payload.dart';
import 'package:pos_application_mobile/data/repositories/size_repository_impl.dart';
import 'package:pos_application_mobile/domain/entities/size_entity.dart';
import 'package:pos_application_mobile/domain/repositories/size_repository.dart';
import 'package:pos_application_mobile/domain/use_cases/use_case.dart';

class StoreDataUseCase extends UseCase<SizeRepository, SizePayload> {
  StoreDataUseCase() : super(SizeRepositoryImpl());

  @override
  Future call([SizePayload? params]) async {
    final SizeEntity data = await repository.storeData(params!);
    return data;
  }
}