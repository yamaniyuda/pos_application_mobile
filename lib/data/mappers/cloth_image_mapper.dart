import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:pos_application_mobile/data/dtos/cloth_image_dto.dart';
import 'package:pos_application_mobile/domain/entities/cloth_image_entity.dart';

part 'cloth_image_mapper.g.dart';

@AutoMappr([
  MapType<ClothImageDTO, ClothImageEntity>(),
  MapType<ClothImageEntity, ClothImageDTO>()
])
class ClothImageMapper extends $ClothImageMapper {}