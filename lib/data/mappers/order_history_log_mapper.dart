import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:pos_application_mobile/data/dtos/order_history_log_dto.dart';
import 'package:pos_application_mobile/domain/entities/order_history_log_entity.dart';

part 'order_history_log_mapper.g.dart';

@AutoMappr([
  MapType<OrderHistoryLogDTO, OrderHistoryLogEntity>(),
  MapType<OrderHistoryLogEntity, OrderHistoryLogDTO>()
])
class OrderHistoryLogMapper extends $OrderHistoryLogMapper {}