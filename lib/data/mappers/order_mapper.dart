import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:pos_application_mobile/data/dtos/cloth_dto.dart';
import 'package:pos_application_mobile/data/dtos/created_by_dto.dart';
import 'package:pos_application_mobile/data/dtos/customer_dto.dart';
import 'package:pos_application_mobile/data/dtos/order_dto.dart';
import 'package:pos_application_mobile/data/dtos/order_history_log_dto.dart';
import 'package:pos_application_mobile/data/dtos/order_payment_log_dto.dart';
import 'package:pos_application_mobile/data/mappers/cloth_mapper.dart';
import 'package:pos_application_mobile/data/mappers/created_by_mapper.dart';
import 'package:pos_application_mobile/data/mappers/customer_mapper.dart';
import 'package:pos_application_mobile/data/mappers/order_history_log_mapper.dart';
import 'package:pos_application_mobile/data/mappers/order_payment_log_mapper.dart';
import 'package:pos_application_mobile/domain/entities/cloth_entity.dart';
import 'package:pos_application_mobile/domain/entities/created_by_entity.dart';
import 'package:pos_application_mobile/domain/entities/customer_entity.dart';
import 'package:pos_application_mobile/domain/entities/order_entity.dart';
import 'package:pos_application_mobile/domain/entities/order_history_log_entity.dart';
import 'package:pos_application_mobile/domain/entities/order_payment_log_entity.dart';

part 'order_mapper.g.dart';

@AutoMappr([
  MapType<OrderDTO, OrderEntity>(
    fields: [
      Field('createdBy', custom: OrderMapper.createdByToEntity),
      Field('orderPaymentLog', custom: OrderMapper.listOrderPaymentLogToEntity),
      Field('orderHistoryLog', custom: OrderMapper.listOrderHistoryLogToEntity),
      Field('customer', custom: OrderMapper.customerToEntity),
      Field('cloths', custom: OrderMapper.listClothToEntity)
    ]
  ),
  MapType<OrderEntity, OrderDTO>(
    fields: [
      Field('createdBy', custom: OrderMapper.createdByToDto),
      Field('orderPaymentLog', custom: OrderMapper.listOrderPaymentLogToDTO),
      Field('orderHistoryLog', custom: OrderMapper.listOrderHistoryLogToDto),
      Field('customer', custom: OrderMapper.customerToDto),
      Field('cloths', custom: OrderMapper.listClothToDto)
    ]
  )
])
class OrderMapper extends $OrderMapper {

  /// ========== Created By ================
  static CreatedByEntity? createdByToEntity(OrderDTO dto) {
    return CreatedByMapper().tryConvert<CreatedByDTO, CreatedByEntity>(dto.createdBy);
  }
  static CreatedByDTO? createdByToDto(OrderEntity entity) {
    return CreatedByMapper().tryConvert<CreatedByEntity, CreatedByDTO>(entity.createdBy);
  }
  /// ========== End Created By ============
  


  /// ========== Order History Log Entity ===============
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
  /// ========== End Order History Log Entity ============



  /// =========== Order Payment Log Entity ================
  static List<OrderPaymentLogEntity>? listOrderPaymentLogToEntity (OrderDTO dto) {
    if (dto.orderHistoryLog == null) return null;

    return List<OrderPaymentLogEntity>.from(
      dto.orderPaymentLog!.map((e) => OrderPaymentLogMapper().convert<OrderPaymentLogDTO, OrderPaymentLogEntity>(e))
    );
  }
  static List<OrderPaymentLogDTO>? listOrderPaymentLogToDTO(OrderEntity entity) {
    if (entity.orderPaymentLog == null) return null;

    return List<OrderPaymentLogDTO>.from(
      entity.orderPaymentLog!.map((e) => OrderPaymentLogMapper().convert<OrderPaymentLogEntity, OrderPaymentLogDTO>(e))
    );
  } 
  /// =========== End Payment Log Entity ==================



  /// ================== Customer =========================
  static CustomerEntity? customerToEntity(OrderDTO dto) {
    return CustomerMapper().convert<CustomerDTO, CustomerEntity>(dto.customer);
  }
  static CustomerDTO? customerToDto(OrderEntity entity) {
    return CustomerMapper().convert<CustomerEntity, CustomerDTO>(entity.customer);
  }
  /// ================== End Customer ====================
  


  /// =================== List Cloth ==========================
  static List<ClothEntity>? listClothToEntity(OrderDTO dto) {
    if (dto.cloths == null) return null;

    return List<ClothEntity>.from(
      dto.cloths!.map((e) => ClothMapper().convert<ClothDTO, ClothEntity>(e))
    );
  }
  static List<ClothDTO>? listClothToDto(OrderEntity entity) {
    if (entity.cloths == null) return null;

    return List<ClothDTO>.from(
      entity.cloths!.map((e) => ClothMapper().convert<ClothEntity, ClothDTO>(e))
    );
  }
  /// ================== End List Cloth =======================
}