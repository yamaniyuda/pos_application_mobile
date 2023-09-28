
import 'package:pos_application_mobile/data/data_source/remote_data_sources/order_data_source.dart';
import 'package:pos_application_mobile/data/dtos/order_dto.dart';
import 'package:pos_application_mobile/data/mappers/order_mapper.dart';
import 'package:pos_application_mobile/data/payloads/order_payload.dart';
import 'package:pos_application_mobile/domain/entities/order_entity.dart';
import 'package:pos_application_mobile/domain/repositories/order_repository.dart';

class OrderRepositoryImpl extends OrderRepository {
  OrderRepositoryImpl()
    : super(
      mapper: OrderMapper(),
      dataSource: OrderDataSource()
    );

  @override
  Future<List<OrderEntity>> fetchData(Map<String, dynamic>? queryParameters) async {
    final List<OrderDTO> dataDTO = await dataSource.fetchData(queryParameters);
    final List<OrderEntity> dataEntity = List<OrderEntity>.from(
      dataDTO.map((dto) => mapper.convert<OrderDTO, OrderEntity>(dto))
    );
    return dataEntity;
  }

  @override
  Future<String> storeData(OrderPayload payload) async {
    final String dataDTO = await dataSource.storeData(payload);
    return dataDTO;
  }
  
  @override
  Future<void> deleteData(String id) async {
    await dataSource.deleteData(id);
  }
  
  @override
  Future<OrderEntity> updateData(String id, OrderPayload payload) async {
    final OrderDTO dataDTO = await dataSource.updateData(id, payload);
    final OrderEntity dataEntity = mapper.convert<OrderDTO, OrderEntity>(dataDTO);

    return dataEntity;
  }
  
  @override
  Future<OrderEntity> fetchDetailData(String id) async {
    final OrderDTO dataDTO = await dataSource.fetchDetailData(id, {});
    final OrderEntity orderEntity = mapper.convert<OrderDTO, OrderEntity>(dataDTO);
    
    return orderEntity;
  }
}