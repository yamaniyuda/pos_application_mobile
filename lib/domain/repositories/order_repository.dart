import 'package:pos_application_mobile/data/data_source/remote_data_sources/order_data_source.dart';
import 'package:pos_application_mobile/data/mappers/order_mapper.dart';
import 'package:pos_application_mobile/data/payloads/order_payload.dart';
import 'package:pos_application_mobile/domain/entities/order_entity.dart';
import 'package:pos_application_mobile/domain/repositories/repository.dart';

abstract class OrderRepository extends Repository {
  final OrderDataSource dataSource;
  final OrderMapper mapper;

  OrderRepository({
    required this.mapper,
    required this.dataSource
  });

  Future<List<OrderEntity>> fetchData(Map<String, dynamic>? queryParameters);
  Future<OrderEntity> storeData(OrderPayload payload);
  Future<void> deleteData(String id);
  Future<OrderEntity>  updateData(String id, OrderPayload payload);
}