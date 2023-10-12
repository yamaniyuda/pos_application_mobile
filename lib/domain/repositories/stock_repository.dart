import 'package:pos_application_mobile/data/data_source/remote_data_sources/stock_data_source.dart';
import 'package:pos_application_mobile/data/mappers/stock_mapper.dart';
import 'package:pos_application_mobile/data/payloads/stock_adjustment_payload.dart';
import 'package:pos_application_mobile/domain/entities/stock_entity.dart';
import 'package:pos_application_mobile/domain/repositories/repository.dart';

abstract class StockRepository extends Repository {
  final StockDataSource dataSource;
  final StockMapper mapper;

  StockRepository({
    required this.mapper,
    required this.dataSource
  });

  Future<List<StockEntity>> fetchData(Map<String, dynamic>? queryParameters);
  Future<StockEntity> stockAdjustment(StockAdjustmentPayload payload);
}