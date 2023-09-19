import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:pos_application_mobile/data/dtos/created_by_dto.dart';
import 'package:pos_application_mobile/data/dtos/order_dto.dart';
import 'package:pos_application_mobile/data/dtos/order_history_log_dto.dart';
import 'package:pos_application_mobile/data/dtos/order_payment_log_dto.dart';
import 'package:pos_application_mobile/data/mappers/created_by_mapper.dart';
import 'package:pos_application_mobile/data/mappers/order_history_log_mapper.dart';
import 'package:pos_application_mobile/data/mappers/order_payment_log_mapper.dart';
import 'package:pos_application_mobile/domain/entities/cloth_entity.dart';
import 'package:pos_application_mobile/domain/entities/created_by_entity.dart';
import 'package:pos_application_mobile/domain/entities/order_entity.dart';
import 'package:pos_application_mobile/domain/entities/order_history_log_entity.dart';
import 'package:pos_application_mobile/domain/entities/order_payment_log_entity.dart';

part 'order_mapper.g.dart';

@AutoMappr([
  MapType<OrderDTO, OrderEntity>(
    fields: [
      Field('')
    ]
  ),
  MapType<OrderEntity, OrderDTO>()
])
class OrderMapper extends $OrderMapper {
  static CreatedByEntity? createdByToEntity(OrderDTO dto) {
    return CreatedByMapper().tryConvert<CreatedByDTO, CreatedByEntity>(dto.createdBy);
  }

  static CreatedByDTO? createdByToDto(OrderEntity entity) {
    return CreatedByMapper().tryConvert<CreatedByEntity, CreatedByDTO>(entity.createdBy);
  }

  static List<OrderHistoryLogEntity>? listOrderHistoryLogToEntity(OrderDTO dto) {
    if (dto.orderHistoryLog == null) return null;

    return List<OrderHistoryLogEntity>.from(
      dto.orderHistoryLog!.map((e) => OrderHistoryLogMapper().convert<OrderHistoryLogDTO, OrderHistoryLogEntity>(e))
    );
  }

  static List<OrderHistoryLogDTO>? listOrderHistoryLogToDto(OrderEntity entity) {
    if (entity.orderHistoryLog == null) return null;

    return List<OrderHistoryLogDTO>.from(
      entity.orderHistoryLog!.map((e) => OrderHistoryLogMapper().convert<OrderHistoryLogEntity, OrderHistoryLogDTO>(e))
    );
  }

  static List<OrderPaymentLogEntity>? listOrderPaymentLogToEntity (OrderDTO dto) {
    if (dto.orderHistoryLog == null) return null;

    return List<OrderPaymentLogEntity>.from(
      dto.orderPaymentLog!.map((e) => OrderPaymentLogMapper().convert<OrderPaymentLogDTO, OrderPaymentLogEntity>(e))
    );
  }
}