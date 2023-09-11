import 'package:image_picker/image_picker.dart';
import 'package:pos_application_mobile/data/payloads/payload.dart';

class ClothImagePayload extends Payload {
  final String id;
  final String clothId;
  final XFile image;

  ClothImagePayload({
    this.id = '',
    required this.clothId,
    required this.image,
  });


  @override
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "cloth_id": clothId,
      "image": image,
    };
  }
}