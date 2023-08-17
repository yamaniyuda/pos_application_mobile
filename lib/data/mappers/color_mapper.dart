import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:pos_application_mobile/data/dtos/color_dto.dart';
import 'package:pos_application_mobile/domain/entities/color_entity.dart';

part 'color_mapper.g.dart';
@AutoMappr([
  MapType<ColorDTO, ColorEntity>(),
  MapType<ColorEntity, ColorDTO>()
])
class ColorMapper extends $ColorMapper {}