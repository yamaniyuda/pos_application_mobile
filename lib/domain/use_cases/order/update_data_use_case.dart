import 'package:pos_application_mobile/data/payloads/order_payload.dart';
import 'package:pos_application_mobile/data/repositories/order_repository_impl.dart';
import 'package:pos_application_mobile/domain/entities/order_entity.dart';
import 'package:pos_application_mobile/domain/repositories/order_repository.dart';
import 'package:pos_application_mobile/domain/use_cases/use_case.dart';

class UpdateDataUseCase extends UseCase<OrderRepository, OrderPayload> {
  UpdateDataUseCase() : super(OrderRepositoryImpl());
  
  @override
  Future<OrderEntity> call([OrderPayload? params]) async {
    final OrderEntity data = await repository.updateData(params!.id!, params);
    return data;
  }
}