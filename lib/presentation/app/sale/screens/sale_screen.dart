import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_application_mobile/app/config/routes/app_screens.dart';
import 'package:pos_application_mobile/app/extensions/string_extention.dart';
import 'package:pos_application_mobile/presentation/app/sale/controllers/sale_controller.dart';
import 'package:pos_application_mobile/presentation/app/sale/widgets/sale_widget/sale_filter_widget.dart';
import 'package:pos_application_mobile/presentation/app/sale/widgets/sale_widget/sale_widget.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_form/pam_form.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_list_scroll/pam_list_scroll.dart';

class SaleScreen extends StatelessWidget {
  final controller = Get.find<SaleController>();
  SaleScreen({super.key});
  

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white, 
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(bottom: 4, right: 10, left: 10),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(10)
              ),
              child: PAMFormTextFieldWidget(
                hintText: "${"search".tr} ${"sale".tr} ( ${"kode number".tr} / ${"customer".tr} )".toCapitalize(),
                decoration: const BoxDecoration(),
                onChanged: (value) {
                  controller.searchData({ 
                    "order_number": value,
                    "customer_name": value
                  });
                },
              ),
            ),
          ),
          Container(
            width: 60,
            alignment: Alignment.center,
            color: Colors.white,
            child: GestureDetector(
              onTap: () => Get.bottomSheet(
                SaleFilterWidget(),
                isScrollControlled: true
              ),
              child: const Icon(Icons.tune),
            ),
          )
        ],
      ),
    );
  }

  
  Widget _buildListOrder() {
    return Obx(() {
      if (controller.isLoading && controller.data.isEmpty) {
        return const Expanded(
          child: Center(
          child: CircularProgressIndicator(),
        ));
      }

      return Expanded(
        child: PAMListScroll(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          onRefresh: () => controller.fetchData(refresh: true),
          itemCount: controller.data.length,
          scrollToRefresh: controller.currentPage == controller.totalPage ? null : controller.fetchData,
          itemBuilder: (context, index) {
            return SaleWidget(orderEntity: controller.data[index],);
          },
        )
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("sale".tr.toCapitalize()),
        backgroundColor: Colors.white
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildListOrder()
          ],
        )
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'floating-acction-button-sale',
        onPressed: () async {
          final result = await Get.toNamed(Routes.saleForm);

          if (result is String) {
            controller.fetchData(refresh: true);
          }
        },
        backgroundColor: Theme.of(Get.context!).primaryColor,
        child: const Icon(Icons.add),
      ),
    ); 
  }
}