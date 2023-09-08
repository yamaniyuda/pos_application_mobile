import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:pos_application_mobile/data/dtos/cloth_color_dto.dart';
import 'package:pos_application_mobile/data/dtos/cloth_size_dto.dart';
import 'package:pos_application_mobile/data/dtos/color_dto.dart';
import 'package:pos_application_mobile/data/mappers/cloth_size_mapper.dart';
import 'package:pos_application_mobile/data/mappers/color_mapper.dart';
import 'package:pos_application_mobile/domain/entities/cloth_color_entity.dart';
import 'package:pos_application_mobile/domain/entities/cloth_size_entity.dart';
import 'package:pos_application_mobile/domain/entities/color_entity.dart';

part 'cloth_color_mapper.g.dart';

@AutoMappr([
  MapType<ClothColorDTO, ClothColorEntity>(fields: [
    Field('color', custom: ClothColorMapper.colorDtoToEntity),
    Field('clothSizes', custom: ClothColorMapper.listClothSizeDtoToEntity)
  ]),
  MapType<ClothColorEntity, ClothColorDTO>(fields: [
    Field('color', custom: ClothColorMapper.colorEntityToDto),
    Field('clothSizes', custom: ClothColorMapper.listClothDtoEntityToDto)
  ]),
])
class ClothColorMapper extends $ClothColorMapper {
  static ColorEntity? colorDtoToEntity(ClothColorDTO dto) {
    return ColorMapper().tryConvert<ColorDTO, ColorEntity>(dto.color);
  }

  static ColorDTO? colorEntityToDto(ClothColorEntity entity) {
    return ColorMapper().tryConvert<ColorEntity, ColorDTO>(entity.color);
  }

  static List<ClothSizeEntity>? listClothSizeDtoToEntity(ClothColorDTO dto) {
    if (dto.clothSizes == null) return null;

    return List<ClothSizeEntity>.from(dto.clothSizes!.map(
        (e) => ClothSizeMapper().convert<ClothSizeDTO, ClothSizeEntity>(e)));
  }

  static List<ClothSizeDTO>? listClothDtoEntityToDto(ClothColorEntity entity) {
    if (entity.clothSizes == null) return null;

    return List<ClothSizeDTO>.from(entity.clothSizes!.map(
        (e) => ClothSizeMapper().convert<ClothSizeEntity, ClothSizeDTO>(e)));
  }
}
