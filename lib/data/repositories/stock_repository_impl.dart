
import 'package:pos_application_mobile/data/data_source/remote_data_sources/stock_data_source.dart';
import 'package:pos_application_mobile/data/dtos/stock_dto.dart';
import 'package:pos_application_mobile/data/mappers/stock_mapper.dart';
import 'package:pos_application_mobile/data/payloads/stock_adjustment_payload.dart';
import 'package:pos_application_mobile/domain/entities/stock_entity.dart';
import 'package:pos_application_mobile/domain/repositories/stock_repository.dart';

class StockRepositoryImpl extends StockRepository {
  StockRepositoryImpl()
    : super(
      mapper: StockMapper(),
      dataSource: StockDataSource()
    );

  @override
  Future<List<StockEntity>> fetchData(Map<String, dynamic>? queryParameters) async {
    final List<StockDTO> dataDTO = await dataSource.fetchData(queryParameters);
    final List<StockEntity> dataEntity = List<StockEntity>.from(
      dataDTO.map((dto) => mapper.convert<StockDTO, StockEntity>(dto))
    );
    return dataEntity;
  }

  @override
  Future<StockEntity> stockAdjustment(StockAdjustmentPayload payload) async {
    final StockDTO dataDTO = await dataSource.stockAdjustment(payload);
    return mapper.convert<StockDTO, StockEntity>(dataDTO);
  }
}