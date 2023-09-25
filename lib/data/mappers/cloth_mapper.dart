import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:pos_application_mobile/data/dtos/cloth_categoty_dto.dart';
import 'package:pos_application_mobile/data/dtos/cloth_color_dto.dart';
import 'package:pos_application_mobile/data/dtos/cloth_dto.dart';
import 'package:pos_application_mobile/data/dtos/created_by_dto.dart';
import 'package:pos_application_mobile/data/dtos/updated_by_dto.dart';
import 'package:pos_application_mobile/data/mappers/cloth_category_mapper.dart';
import 'package:pos_application_mobile/data/mappers/cloth_color_mapper.dart';
import 'package:pos_application_mobile/data/mappers/created_by_mapper.dart';
import 'package:pos_application_mobile/data/mappers/updated_by_mapper.dart';
import 'package:pos_application_mobile/domain/entities/cloth_category_entity.dart';
import 'package:pos_application_mobile/domain/entities/cloth_color_entity.dart';
import 'package:pos_application_mobile/domain/entities/cloth_entity.dart';
import 'package:pos_application_mobile/domain/entities/created_by_entity.dart';
import 'package:pos_application_mobile/domain/entities/updated_by_entity.dart';

part 'cloth_mapper.g.dart';

@AutoMappr([
  MapType<ClothDTO, ClothEntity>(fields: [
    Field('createdBy', custom: ClothMapper.createdByDtoToEntity),
    Field('updatedBy', custom: ClothMapper.updatedByDtoToEntity),
    Field('clothCategory', custom: ClothMapper.clothCategoryDtoToEntity),
    Field('clothColors', custom: ClothMapper.listClothColorDtoToEntity),
  ]),
  MapType<ClothEntity, ClothDTO>(fields: [
    Field('createdBy', custom: ClothMapper.createdByEntityToDto),
    Field('updatedBy', custom: ClothMapper.updatedByEntityToDto),
    Field('clothCategory', custom: ClothMapper.clothCategoryEntityToDto),
    Field('clothColors', custom: ClothMapper.listClothColorEntityToDTO),
  ])
])
class ClothMapper extends $ClothMapper {
  static CreatedByEntity? createdByDtoToEntity(ClothDTO dto) {
    if (dto.createdBy is String) return null;
    return CreatedByMapper()
        .tryConvert<CreatedByDTO, CreatedByEntity>(dto.createdBy);
  }

  static CreatedByDTO? createdByEntityToDto(ClothEntity entity) {
    if (entity.createdBy is String) return null;
    return CreatedByMapper()
        .tryConvert<CreatedByEntity, CreatedByDTO>(entity.createdBy);
  }

  static UpdatedByEntity? updatedByDtoToEntity(ClothDTO dto) {
    return UpdatedByMapper()
        .tryConvert<UpdatedByDTO, UpdatedByEntity>(dto.updatedBy);
  }

  static UpdatedByDTO? updatedByEntityToDto(ClothEntity entity) {
    return UpdatedByMapper()
        .tryConvert<UpdatedByEntity, UpdatedByDTO>(entity.updatedBy);
  }

  static ClothCategoryEntity? clothCategoryDtoToEntity(ClothDTO dto) {
    return ClothCategoryMapper()
        .tryConvert<ClothCategoryDTO, ClothCategoryEntity>(dto.clothCategory);
  }

  static ClothCategoryDTO? clothCategoryEntityToDto(ClothEntity entity) {
    return ClothCategoryMapper()
        .tryConvert<ClothCategoryEntity, ClothCategoryDTO>(
            entity.clothCategory);
  }

  static List<ClothColorEntity>? listClothColorDtoToEntity(ClothDTO dto) {
    if (dto.clothColors == null) return null;

    return List<ClothColorEntity>.from(dto.clothColors!.map(
        (e) => ClothColorMapper().convert<ClothColorDTO, ClothColorEntity>(e)));
  }

  static List<ClothColorDTO>? listClothColorEntityToDTO(ClothEntity entity) {
    if (entity.clothColors == null) return null;

    return List<ClothColorDTO>.from(entity.clothColors!.map(
        (e) => ClothColorMapper().convert<ClothColorEntity, ClothColorDTO>(e)));
  }
}
