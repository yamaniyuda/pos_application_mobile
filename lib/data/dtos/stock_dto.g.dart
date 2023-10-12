// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StockDTO _$StockDTOFromJson(Map<String, dynamic> json) => StockDTO(
      createdAt: json['created_at'] as String?,
      createdBy: json['created_by'] == null
          ? null
          : CreatedByDTO.fromJson(json['created_by'] as Map<String, dynamic>),
      currentStock: json['current_stock'] as int?,
      id: json['id'] as String?,
      note: json['note'] as String?,
      previousStock: json['previous_stock'] as int?,
      referral: json['referral'] as String?,
      referralId: json['referral_id'] as String?,
      stockIn: json['stock_in'] as int?,
      stockOut: json['stock_out'] as int?,
      updatedAt: json['updated_at'] as String?,
      clothStock: json['cloth_stock'] == null
          ? null
          : ClothStockDTO.fromJson(json['cloth_stock'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StockDTOToJson(StockDTO instance) => <String, dynamic>{
      'id': instance.id,
      'created_by': instance.createdBy,
      'referral_id': instance.referralId,
      'referral': instance.referral,
      'previous_stock': instance.previousStock,
      'stock_in': instance.stockIn,
      'stock_out': instance.stockOut,
      'current_stock': instance.currentStock,
      'note': instance.note,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'cloth_stock': instance.clothStock,
    };
