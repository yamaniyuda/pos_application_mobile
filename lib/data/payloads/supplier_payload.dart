import 'package:pos_application_mobile/data/payloads/payload.dart';

class SupplierPayload extends Payload {
  final String id;
  final String name;
  final String email;
  final String address;
  final String phone;
  final String phoneNumber;
  final String provinceId;
  final String regencyId;
  final String districtId;
  final String villageId;

  SupplierPayload({
    required this.name,
    this.id = '',
    this.phone = '',
    this.email = '',
    this.address = '',
    this.phoneNumber = '',
    this.provinceId = '',
    this.districtId = '',
    this.regencyId = '',
    this.villageId = ''
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "address": address,
      "phone": phone,
      "phone_number": phoneNumber,
      "province_id": provinceId,
      "regency_id": regencyId,
      "district_id": districtId,
      "village_id": villageId
    };
  }
}