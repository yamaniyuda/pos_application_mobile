import 'package:get/get.dart';
import 'package:pos_application_mobile/presentation/app/booking/controllers/booking_controller.dart';

class BookingBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BookingController());
  }
}