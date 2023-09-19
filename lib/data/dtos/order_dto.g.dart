// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderDTO _$OrderDTOFromJson(Map<String, dynamic> json) => OrderDTO(
      id: json['id'] as String?,
      createdBy: json['created_by'] == null
          ? null
          : CreatedByDTO.fromJson(json['created_by'] as Map<String, dynamic>),
      orderNumber: json['order_number'] as String?,
      createdAt: json['created_at'] as String?,
      status: json['status'] as String?,
      paymentMethod: json['payment_method'] as String?,
      totalQty: json['total_qty'] as int?,
      amountDownPayment: json['amount_down_payment'] as int?,
      total: json['total'] as int?,
      profit: json['profit'] as int?,
      cloths: (json['cloths'] as List<dynamic>?)
          ?.map((e) => ClothDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      updatedBy: json['updated_by'],
      updatedAt: json['updated_at'] as String?,
      customer: json['customer'] == null
          ? null
          : CustomerDTO.fromJson(json['customer'] as Map<String, dynamic>),
      orderHistoryLog: (json['order_history_log'] as List<dynamic>?)
          ?.map((e) => OrderHistoryLogDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      orderPaymentLog: (json['order_payment_log'] as List<dynamic>?)
          ?.map((e) => OrderPaymentLogDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrderDTOToJson(OrderDTO instance) => <String, dynamic>{
      'id': instance.id,
      'created_by': instance.createdBy,
      'order_number': instance.orderNumber,
      'created_at': instance.createdAt,
      'status': instance.status,
      'payment_method': instance.paymentMethod,
      'total_qty': instance.totalQty,
      'amount_down_payment': instance.amountDownPayment,
      'total': instance.total,
      'profit': instance.profit,
      'updated_by': instance.updatedBy,
      'updated_at': instance.updatedAt,
      'customer': instance.customer,
      'cloths': instance.cloths,
      'order_payment_log': instance.orderPaymentLog,
      'order_history_log': instance.orderHistoryLog,
    };
