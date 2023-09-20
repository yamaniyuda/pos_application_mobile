import 'package:pos_application_mobile/data/repositories/order_repository_impl.dart';
import 'package:pos_application_mobile/domain/entities/order_entity.dart';
import 'package:pos_application_mobile/domain/repositories/order_repository.dart';
import 'package:pos_application_mobile/domain/use_cases/use_case.dart';

class FetchDataUseCase extends UseCase<OrderRepository, Map<String, dynamic>> {
  FetchDataUseCase() : super(OrderRepositoryImpl());

  @override
  Future<List<OrderEntity>> call([Map<String, dynamic>? params]) async {
    final List<OrderEntity> data = await repository.fetchData(params);
    return data;
  }
}