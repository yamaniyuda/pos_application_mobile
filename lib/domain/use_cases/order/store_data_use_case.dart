import 'package:pos_application_mobile/data/payloads/order_payload.dart';
import 'package:pos_application_mobile/data/repositories/order_repository_impl.dart';
import 'package:pos_application_mobile/domain/entities/order_entity.dart';
import 'package:pos_application_mobile/domain/repositories/order_repository.dart';
import 'package:pos_application_mobile/domain/use_cases/use_case.dart';

class StoreDataUseCase extends UseCase<OrderRepository, OrderPayload> {
  StoreDataUseCase() : super(OrderRepositoryImpl());

  @override
  Future call([OrderPayload? params]) async {
    final OrderEntity data = await repository.storeData(params!);
    return data;
  }
}