import 'package:pos_application_mobile/data/repositories/order_repository_impl.dart';
import 'package:pos_application_mobile/domain/entities/order_entity.dart';
import 'package:pos_application_mobile/domain/repositories/order_repository.dart';
import 'package:pos_application_mobile/domain/use_cases/use_case.dart';

class FetchDetailDataUseCase extends UseCase<OrderRepository, String> {
  FetchDetailDataUseCase() : super(OrderRepositoryImpl());

  @override
  Future<OrderEntity> call([String? params]) async {
    final OrderEntity data = await repository.fetchDetailData(params!);
    return data;
  }
}