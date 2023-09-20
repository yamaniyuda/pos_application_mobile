import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pos_application_mobile/app/config/routes/app_screens.dart';
import 'package:pos_application_mobile/app/extensions/string_extention.dart';
import 'package:pos_application_mobile/presentation/app/product/controllers/product_controller.dart';
import 'package:pos_application_mobile/presentation/app/product/widgets/product_widget.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_form/pam_form.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_list_scroll/pam_list_scroll.dart';

class ProductScreen extends StatelessWidget {
  final controller = Get.find<ProductController>();
  ProductScreen({super.key});

  
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
                hintText: "${"search".tr} ${"product".tr}".toCapitalize(),
                decoration: const BoxDecoration(),
                // onChanged: controller.searchdata,
              ),
            ),
          ),
          Container(
            width: 60,
            alignment: Alignment.center,
            color: Colors.white,
            child: GestureDetector(
              onTap: () {
                // do filtering
              },
              child: const Icon(Icons.tune),
            ),
          )
        ],
      ),
    );
  }

  
  Widget _buildListCustomerType() {
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
            return ProductWidget(clothEntity: controller.data[index]);
          },
        )
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("product".tr.toCapitalize()),
        actions: [
          IconButton.filled(
            onPressed: () {},
            highlightColor: Colors.white,
            icon: const Icon(Icons.filter_alt_outlined, size: 24),
          ),
          const SizedBox(width: 24)
        ],
        backgroundColor: Colors.white
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildListCustomerType()
          ],
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()  async {
          final result = Get.toNamed(Routes.productForm);
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
