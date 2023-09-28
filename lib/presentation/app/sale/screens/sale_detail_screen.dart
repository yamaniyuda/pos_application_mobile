
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pos_application_mobile/app/extensions/string_extention.dart';
import 'package:pos_application_mobile/app/utils/system_utils.dart';
import 'package:pos_application_mobile/presentation/app/sale/controllers/sale_detail_controller.dart';
import 'package:pos_application_mobile/presentation/app/sale/widgets/detail_sale_widget/header_widget.dart';
import 'package:pos_application_mobile/presentation/app/sale/widgets/detail_sale_widget/item_widget.dart';
import 'package:pos_application_mobile/presentation/app/sale/widgets/detail_sale_widget/payment_list_widget.dart';
import 'package:pos_application_mobile/presentation/app/sale/widgets/detail_sale_widget/sale_list_widget%20.dart';
import 'package:pos_application_mobile/presentation/app/sale/widgets/detail_sale_widget/tab_bar_widget.dart';

class SaleDetailScreen extends GetView<SaleDetailController> {
  const SaleDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    SystemUtils.changeStatusAndBottomBarColor(context,
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Theme.of(context).scaffoldBackgroundColor,
        systemNavigationBarIconBrightness: Brightness.dark);
        
    return GetBuilder<SaleDetailController>(builder: (controller) {
      if (controller.isLoading) {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }

      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("${"detail".tr} ${"sale".tr}".toCapitalize()),
        ),
        body: SafeArea(
          child: DefaultTabController(
            length: 3, 
            child: NestedScrollView(
              // physics: const BouncingScrollPhysics(),
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                HeaderWidget(),
                const TabBarWidget(),
              ],
              body: TabBarView(
                children: [
                  ItemWidget(),
                  PaymentListWidget(),
                  SaleListWidget()
                ],
              )
            )
          ),
        ),
      );
    });
  }
}