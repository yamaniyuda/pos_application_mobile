import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:pos_application_mobile/data/dtos/order_payment_log_dto.dart';
import 'package:pos_application_mobile/domain/entities/order_payment_log_entity.dart';

part 'order_payment_log_mapper.g.dart';

@AutoMappr([
  MapType<OrderPaymentLogDTO, OrderPaymentLogEntity>(),
  MapType<OrderPaymentLogEntity, OrderPaymentLogDTO>()
])
class OrderPaymentLogMapper extends $OrderPaymentLogMapper {}