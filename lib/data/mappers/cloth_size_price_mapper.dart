import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:pos_application_mobile/data/dtos/cloth_price_type_dto.dart';
import 'package:pos_application_mobile/data/dtos/cloth_size_price_dto.dart';
import 'package:pos_application_mobile/data/mappers/cloth_price_type_mapper.dart';
import 'package:pos_application_mobile/domain/entities/cloth_price_type_entity.dart';
import 'package:pos_application_mobile/domain/entities/cloth_size_price_entity.dart';

part 'cloth_size_price_mapper.g.dart';

@AutoMappr([
  MapType<ClothSizePriceDTO, ClothSizePriceEntity>(
    fields: [
      Field('clothPriceType', custom: ClothSizePriceMapper.clothPriceTypeDtoToEntity)
    ]
  ),
  MapType<ClothSizePriceEntity, ClothSizePriceDTO>(
    fields: [
      Field('clothPriceType', custom: ClothSizePriceMapper.clothPriceTypeEntityToDto)
    ]
  )
])
class ClothSizePriceMapper extends $ClothSizePriceMapper {
  static ClothPriceTypeEntity? clothPriceTypeDtoToEntity(ClothSizePriceDTO dto) {
    return ClothPriceTypeMapper().tryConvert<ClothPriceTypeDTO, ClothPriceTypeEntity>(dto.clothPriceType);
  }
  static ClothPriceTypeDTO? clothPriceTypeEntityToDto(ClothSizePriceEntity entity) {
    return ClothPriceTypeMapper().tryConvert<ClothPriceTypeEntity, ClothPriceTypeDTO>(entity.clothPriceType);
  }
}