// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_payment_log_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderPaymentLogDTO _$OrderPaymentLogDTOFromJson(Map<String, dynamic> json) =>
    OrderPaymentLogDTO(
      id: json['id'] as String?,
      createdBy: json['created_by'] == null
          ? null
          : CreatedByDTO.fromJson(json['created_by'] as Map<String, dynamic>),
      paymentMethod: json['payment_method'] as String?,
      status: json['status'] as String?,
      type: json['type'] as String?,
      total: json['total'] as int?,
      note: json['note'] as String?,
      attachment: json['attachment'] as String?,
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$OrderPaymentLogDTOToJson(OrderPaymentLogDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_by': instance.createdBy,
      'payment_method': instance.paymentMethod,
      'status': instance.status,
      'type': instance.type,
      'total': instance.total,
      'created_at': instance.createdAt,
      'note': instance.note,
      'attachment': instance.attachment,
    };
