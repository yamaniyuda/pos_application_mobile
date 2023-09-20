import 'package:pos_application_mobile/data/repositories/order_repository_impl.dart';
import 'package:pos_application_mobile/domain/repositories/order_repository.dart';
import 'package:pos_application_mobile/domain/use_cases/use_case.dart';

class DeleteDataUseCase extends UseCase<OrderRepository, String> {
  DeleteDataUseCase() : super(OrderRepositoryImpl());
  
  @override
  Future call([String? params]) async {
    await repository.deleteData(params!);
  }
}