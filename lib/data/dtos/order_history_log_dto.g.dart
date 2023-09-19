// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_history_log_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderHistoryLogDTO _$OrderHistoryLogDTOFromJson(Map<String, dynamic> json) =>
    OrderHistoryLogDTO(
      id: json['id'] as String?,
      createdBy: json['created_by'] == null
          ? null
          : CreatedByDTO.fromJson(json['created_by'] as Map<String, dynamic>),
      paymentMethod: json['payment_method'] as String?,
      status: json['status'] as String?,
      note: json['note'] as String?,
    );

Map<String, dynamic> _$OrderHistoryLogDTOToJson(OrderHistoryLogDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_by': instance.createdBy,
      'payment_method': instance.paymentMethod,
      'status': instance.status,
      'note': instance.note,
    };
