// ignore_for_file: depend_on_referenced_packages

import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:pos_application_mobile/data/dtos/cloth_price_type_dto.dart';
import 'package:pos_application_mobile/domain/entities/cloth_price_type_entity.dart';

part 'cloth_price_type_mapper.g.dart';
@AutoMappr([
  MapType<ClothPriceTypeDTO, ClothPriceTypeEntity>(
    // fields: [
    //   Field('createdBy', custom: ClothPriceTypeMapper.createdByToEntity)
    // ]
  ),
  MapType<ClothPriceTypeEntity, ClothPriceTypeDTO>(
    // fields: [
    //   Field('createdBy', custom: ClothPriceTypeMapper.createdByToDTO)
    // ]
  )
])
class ClothPriceTypeMapper extends $ClothPriceTypeMapper {
  // static CreatedByEntity? createdByToEntity(ClothPriceTypeDTO dto) {
  //   return CreatedByMapper().tryConvert<CreatedByDTO, CreatedByEntity>(dto.createdBy);
  // }

  // static CreatedByDTO? createdByToDTO(ClothPriceTypeEntity entity) {
  //   return CreatedByMapper().tryConvert<CreatedByEntity, CreatedByDTO>(entity.createdBy);
  // }
}