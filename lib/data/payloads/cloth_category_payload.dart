import 'package:pos_application_mobile/data/payloads/payload.dart';

class ClothCategoryPayload extends Payload {
  final String id;
  final String name;
  final String description;

  ClothCategoryPayload({
    this.id = '',
    required this.name,
    required this.description,
  });


  @override
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "description": description,
    };
  }
}