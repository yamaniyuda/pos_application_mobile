import 'package:pos_application_mobile/data/payloads/payload.dart';

class ColorPayload extends Payload {
  final String id;
  final String name;
  final String description;
  final String codeHexa;
  final int isActive;
  
  ColorPayload({
    this.isActive = 1,
    this.description = '',
    this.id = '',
    required this.name,
    required this.codeHexa
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "description": description,
      "code_hexa": codeHexa,
      "is_active": isActive
    };
  }
}