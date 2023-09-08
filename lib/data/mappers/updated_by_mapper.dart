import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:pos_application_mobile/data/dtos/updated_by_dto.dart';
import 'package:pos_application_mobile/domain/entities/updated_by_entity.dart';

part 'updated_by_mapper.g.dart';

@AutoMappr([
  MapType<UpdatedByDTO, UpdatedByEntity>(),
  MapType<UpdatedByEntity, UpdatedByDTO>()
])
class UpdatedByMapper extends $UpdatedByMapper {}