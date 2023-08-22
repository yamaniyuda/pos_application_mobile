import 'package:pos_application_mobile/data/payloads/payload.dart';

class CustomerPayload extends Payload {
  final String id;
  final String customerCategoryId;
  final String name;
  final String email;
  final String address;
  final String phoneNumber;
  final String provinceId;
  final String regencyId;
  final String districtId;
  final String villageId;

  CustomerPayload({
    required this.customerCategoryId,
    required this.name,
    this.id = '',
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
      "customer_category_id": customerCategoryId,
      "name": name,
      "email": email,
      "address": address,
      "phone_number": phoneNumber,
      "provincy_id": provinceId,
      "regency_id": regencyId,
      "district_id": districtId,
      "village_id": villageId
    };
  }
}