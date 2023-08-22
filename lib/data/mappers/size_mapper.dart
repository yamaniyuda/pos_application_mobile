import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:pos_application_mobile/data/dtos/size_dto.dart';
import 'package:pos_application_mobile/domain/entities/size_entity.dart';

part 'size_mapper.g.dart';
@AutoMappr([
  MapType<SizeDTO, SizeEntity>(),
  MapType<SizeEntity, SizeDTO>()
])
class SizeMapper extends $SizeMapper {}