import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_application_mobile/app/extensions/string_extention.dart';
import 'package:pos_application_mobile/presentation/app/stock/controllers/stock_controller.dart';
import 'package:pos_application_mobile/presentation/app/stock/widget/stock_card_widgt.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_header/header_search_widget.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_list_scroll/pam_list_scroll.dart';

class StockScreen extends GetView<StockController> {
  const StockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("stock".tr.toCapitalize()),
      ),
      body: SafeArea(
        child: Column(
          children: [
            HeaderSearchWidget(
              onChange: (String? value) {},
              onTabFilter: () {},
              placeholder: "${"search".tr} ${"stock".tr}",
            ),
            Obx(() {
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
                    return StockCardWidget(stockEntity: controller.data[index]);
                  },
                )
              );
            })
          ],
        )
      ),
    );
  }
}
