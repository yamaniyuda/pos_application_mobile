import 'package:get/get.dart';
import 'package:pos_application_mobile/domain/entities/order_entity.dart';
import 'package:pos_application_mobile/domain/use_cases/order/order.dart';


class SaleDetailController extends GetxController {
  late FetchDetailDataUseCase _fetchDetailDataUseCase;
  late String _id;

  late OrderEntity dataDetail = OrderEntity();


  final RxBool _isLoading = true.obs;
  bool get isLoading => _isLoading.value;

  @override
  void onInit() async {
    _fetchDetailDataUseCase = FetchDetailDataUseCase();
    _id = Get.parameters["id"]!;
    await _fetchDetailHandling();
    super.onInit();
  }

  
  Future<void> _fetchDetailHandling() async {
    try {
      _isLoading.value = true;
      final OrderEntity dataRespone = await _fetchDetailDataUseCase.call(_id);
      dataDetail = dataRespone;
      
      _isLoading.value = false;
    } catch (e) {
      dataDetail = OrderEntity();
      _isLoading.value = false;
      return;
    } finally {
      update();
    }
  }
}