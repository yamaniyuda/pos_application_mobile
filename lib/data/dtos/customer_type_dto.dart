import 'package:pos_application_mobile/data/dtos/dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'customer_type_dto.g.dart';

@JsonSerializable()
class CustomerTypeDTO implements DTO {
  @JsonKey(name: "id")
  late String? id;

  @JsonKey(name: "name")
  late String? name;

  @JsonKey(name: "description")
  late String? description;

  @JsonKey(name: "created_at")
  late String? createdAt;

  CustomerTypeDTO({this.createdAt, this.description, this.id, this.name});

  factory CustomerTypeDTO.fromJson(Map<String, dynamic> json) {
    return _$CustomerTypeDTOFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$CustomerTypeDTOToJson(this);
  }
}
