import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:pos_application_mobile/data/dtos/cloth_size_dto.dart';
import 'package:pos_application_mobile/data/dtos/cloth_size_price_dto.dart';
import 'package:pos_application_mobile/data/dtos/size_dto.dart';
import 'package:pos_application_mobile/data/mappers/cloth_size_price_mapper.dart';
import 'package:pos_application_mobile/data/mappers/size_mapper.dart';
import 'package:pos_application_mobile/domain/entities/cloth_size_entity.dart';
import 'package:pos_application_mobile/domain/entities/cloth_size_price_entity.dart';
import 'package:pos_application_mobile/domain/entities/size_entity.dart';

part 'cloth_size_mapper.g.dart';

@AutoMappr([
  MapType<ClothSizeDTO, ClothSizeEntity>(
    fields: [
      Field('clothSizePrices', custom: ClothSizeMapper.listClothSizePriceDtoToEntity),
      Field('size', custom: ClothSizeMapper.sizeDtoToEntity)
    ]
  ),
  MapType<ClothSizeEntity, ClothSizeDTO>(
    fields: [
      Field('clothSizePrices', custom: ClothSizeMapper.listClothSizePriceEntityToDto),
      Field('size', custom: ClothSizeMapper.sizeEntityToDto)
    ]
  )
])
class ClothSizeMapper extends $ClothSizeMapper {
  static List<ClothSizePriceEntity>? listClothSizePriceDtoToEntity(ClothSizeDTO dto) {
    if (dto.clothSizePrices == null) return null;

    return List<ClothSizePriceEntity>.from(
      dto.clothSizePrices!.map((e) => ClothSizePriceMapper().convert<ClothSizePriceDTO, ClothSizePriceEntity>(e))
    );
  }
  static List<ClothSizePriceDTO>? listClothSizePriceEntityToDto(ClothSizeEntity entity) {
    if (entity.clothSizePrices == null) return null;

    return List<ClothSizePriceDTO>.from(
      entity.clothSizePrices!.map((e) => ClothSizePriceMapper().convert<ClothSizePriceEntity, ClothSizePriceDTO>(e))
    );
  }
  static SizeEntity? sizeDtoToEntity(ClothSizeDTO dto) {
    return SizeMapper().tryConvert<SizeDTO, SizeEntity>(dto.size);
  }
  static SizeDTO? sizeEntityToDto(ClothSizeEntity entity) {
    return SizeMapper().tryConvert<SizeEntity, SizeDTO>(entity.size);
  }
}