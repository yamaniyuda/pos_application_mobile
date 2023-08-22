import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:pos_application_mobile/data/dtos/village_dto.dart';
import 'package:pos_application_mobile/domain/entities/village_entity.dart';

part 'village_mapper.g.dart';

@AutoMappr([
  MapType<VillageDTO, VillageEntity>(),
  MapType<VillageEntity, VillageDTO>()
])
class VillageMapper extends $VillageMapper {}