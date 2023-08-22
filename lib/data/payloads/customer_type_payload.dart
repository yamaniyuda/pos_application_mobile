import 'package:pos_application_mobile/data/payloads/payload.dart';

class CustomerTypePayload extends Payload {
  final String id;
  final String name;
  final String description;
  
  CustomerTypePayload({
    this.id = '',
    required this.name,
    required this.description
  }); 
  
  @override
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "description": description
    };
  }
}