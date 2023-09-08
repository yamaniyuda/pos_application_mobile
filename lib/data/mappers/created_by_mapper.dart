import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:pos_application_mobile/data/dtos/created_by_dto.dart';
import 'package:pos_application_mobile/domain/entities/created_by_entity.dart';

part 'created_by_mapper.g.dart';
@AutoMappr([
  MapType<CreatedByDTO, CreatedByEntity>(),
  MapType<CreatedByEntity, CreatedByDTO>()
])
class CreatedByMapper extends $CreatedByMapper {}