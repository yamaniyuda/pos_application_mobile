import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:pos_application_mobile/data/dtos/cloth_categoty_dto.dart';
import 'package:pos_application_mobile/domain/entities/cloth_category_entity.dart';

part 'cloth_category_mapper.g.dart';
@AutoMappr([
  MapType<ClothCategoryDTO, ClothCategoryEntity>(),
  MapType<ClothCategoryEntity, ClothCategoryDTO>()
])
class ClothCategoryMapper extends $ClothCategoryMapper {}