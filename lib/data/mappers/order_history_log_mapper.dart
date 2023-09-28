import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:pos_application_mobile/data/dtos/created_by_dto.dart';
import 'package:pos_application_mobile/data/dtos/order_history_log_dto.dart';
import 'package:pos_application_mobile/data/mappers/created_by_mapper.dart';
import 'package:pos_application_mobile/domain/entities/created_by_entity.dart';
import 'package:pos_application_mobile/domain/entities/order_history_log_entity.dart';

part 'order_history_log_mapper.g.dart';

@AutoMappr([
  MapType<OrderHistoryLogDTO, OrderHistoryLogEntity>(
    fields: [
      Field('createdBy', custom: OrderHistoryLogMapper.createdByToEntity),
    ]
  ),
  MapType<OrderHistoryLogEntity, OrderHistoryLogDTO>(
    fields: [
      Field('createdBy', custom: OrderHistoryLogMapper.createdByToDto),
    ]
  )
])
class OrderHistoryLogMapper extends $OrderHistoryLogMapper {
  static CreatedByEntity? createdByToEntity(OrderHistoryLogDTO dto) {
    return CreatedByMapper().tryConvert<CreatedByDTO, CreatedByEntity>(dto.createdBy);
  }
  static CreatedByDTO? createdByToDto(OrderHistoryLogEntity entity) {
    return CreatedByMapper().tryConvert<CreatedByEntity, CreatedByDTO>(entity.createdBy);
  }
}