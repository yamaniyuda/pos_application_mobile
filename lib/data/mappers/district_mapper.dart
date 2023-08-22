import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:pos_application_mobile/data/dtos/district_dto.dart';
import 'package:pos_application_mobile/domain/entities/district_entity.dart';

part 'district_mapper.g.dart';

@AutoMappr([
  MapType<DistrictDTO, DistrictEntity>(),
  MapType<DistrictEntity, DistrictDTO>()
])
class DistrictMapper extends $DistrictMapper {}