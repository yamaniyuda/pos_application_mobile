import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:pos_application_mobile/data/dtos/provincy_dto.dart';
import 'package:pos_application_mobile/domain/entities/provincy_entity.dart';

part 'provincy_mapper.g.dart';

@AutoMappr([
  MapType<ProvincyDTO, ProvincyEntity>(),
  MapType<ProvincyEntity, ProvincyDTO>()
])
class ProvincyMapper extends $ProvincyMapper {}