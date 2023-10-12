import 'package:pos_application_mobile/data/payloads/stock_adjustment_payload.dart';
import 'package:pos_application_mobile/data/repositories/stock_repository_impl.dart';
import 'package:pos_application_mobile/domain/entities/stock_entity.dart';
import 'package:pos_application_mobile/domain/repositories/stock_repository.dart';
import 'package:pos_application_mobile/domain/use_cases/use_case.dart';

class StockAdjustmentUseCase extends UseCase<StockRepository, StockAdjustmentPayload> {
  StockAdjustmentUseCase() : super(StockRepositoryImpl());

  @override
  Future<StockEntity> call([StockAdjustmentPayload? params]) async {
    final StockEntity data = await repository.stockAdjustment(params!);
    return data;
  }
}