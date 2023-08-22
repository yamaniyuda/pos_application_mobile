import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:pos_application_mobile/data/dtos/regency_dto.dart';
import 'package:pos_application_mobile/domain/entities/regency_entity.dart';

part 'regency_mapper.g.dart';

@AutoMappr([
  MapType<RegencyDTO, RegencyEntity>(),
  MapType<RegencyEntity, RegencyDTO>()
])
class RegencyMapper extends $RegencyMapper {}