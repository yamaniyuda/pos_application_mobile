import 'package:pos_application_mobile/data/payloads/payload.dart';

class SizePayload extends Payload {
  final String id;
  final String name;
  final String description;
  final String slug;
  final int isActive;

  SizePayload({
    this.id = '',
    required this.name,
    this.slug = '',
    required this.description,
    this.isActive = 1
  });


  @override
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "is_active": isActive
    };
  }
}