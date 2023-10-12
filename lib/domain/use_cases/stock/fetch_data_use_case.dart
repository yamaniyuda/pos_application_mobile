import 'package:pos_application_mobile/data/repositories/stock_repository_impl.dart';
import 'package:pos_application_mobile/domain/entities/stock_entity.dart';
import 'package:pos_application_mobile/domain/repositories/stock_repository.dart';
import 'package:pos_application_mobile/domain/use_cases/use_case.dart';

class FetchDataUseCase extends UseCase<StockRepository, Map<String, dynamic>> {
  FetchDataUseCase() : super(StockRepositoryImpl());

  @override
  Future<List<StockEntity>> call([Map<String, dynamic>? params]) async {
    final List<StockEntity> data = await repository.fetchData(params);
    return data;
  }
}