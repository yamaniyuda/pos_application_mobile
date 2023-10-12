import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:pos_application_mobile/data/dtos/created_by_dto.dart';
import 'package:pos_application_mobile/data/dtos/order_payment_log_dto.dart';
import 'package:pos_application_mobile/data/mappers/created_by_mapper.dart';
import 'package:pos_application_mobile/domain/entities/created_by_entity.dart';
import 'package:pos_application_mobile/domain/entities/order_payment_log_entity.dart';

part 'order_payment_log_mapper.g.dart';

@AutoMappr([
  MapType<OrderPaymentLogDTO, OrderPaymentLogEntity>(
    fields: [
      Field('createdBy', custom: OrderPaymentLogMapper.createdByToEntity),
    ]
  ),
  MapType<OrderPaymentLogEntity, OrderPaymentLogDTO>(
    fields: [
      Field('createdBy', custom: OrderPaymentLogMapper.createdByToDto),
    ]
  )
])
class OrderPaymentLogMapper extends $OrderPaymentLogMapper {
  static CreatedByEntity? createdByToEntity(OrderPaymentLogDTO dto) {
    return CreatedByMapper().tryConvert<CreatedByDTO, CreatedByEntity>(dto.createdBy);
  }
  static CreatedByDTO? createdByToDto(OrderPaymentLogEntity entity) {
    return CreatedByMapper().tryConvert<CreatedByEntity, CreatedByDTO>(entity.createdBy);
  }
}