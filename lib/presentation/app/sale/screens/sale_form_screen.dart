// ignore_for_file: unrelated_type_equality_checks

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pos_application_mobile/app/extensions/string_extention.dart';
import 'package:pos_application_mobile/app/utils/system_utils.dart';
import 'package:pos_application_mobile/presentation/app/sale/controllers/sale_form_controller.dart';
import 'package:pos_application_mobile/presentation/app/sale/widgets/customer_choose_widget.dart';
import 'package:pos_application_mobile/presentation/app/sale/widgets/sale_total_widget.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_bottom/pam_bottom.dart';

import '../widgets/cloth_color_form_widget.dart';

class SaleFormScreen extends GetView<SaleFormController> {
  const SaleFormScreen({super.key});

  
  String _getTitle() {
    return "${"store".tr} ${"sale".tr}".toCapitalize();
  }


  @override
  Widget build(BuildContext context) {
    SystemUtils.changeStatusAndBottomBarColor(context);

    return Scaffold(
      body: Obx(() {
        if (controller.isLoading == false) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return SafeArea(
          child: Form(
            child: CustomScrollView(
              slivers: [
                /// app bar sliver.
                SliverAppBar(
                  title: Text(_getTitle()),
                  expandedHeight: controller.getHeightAppBar(),
                  pinned: true,
                  elevation: 2,
                  forceElevated: true,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      padding: const EdgeInsets.all(20),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [

                          /// ======================
                          /// Sale choose customer.
                          /// ======================
                          CustomerChooseWidget(),

                        ],
                      )
                    ),
                  ),
                ),


                /// =======================
                /// Detail cloth choosing.
                /// =======================   
                ClothColorFormWidget(),

                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    verticalDirection: VerticalDirection.up,
                    children: [

                      /// ===============
                      /// Submit Button
                      /// ===============
                      Container(
                        color: Colors.white,
                        padding: const EdgeInsets.only(
                          top: 20,
                          left: 20,
                          right: 20,
                          bottom: 20
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            PAMBottom(
                              borderRadius: BorderRadius.circular(10),
                              title: "submit".tr.toCapitalize(),
                            ),
                          ]
                        )
                      ),


                      /// ===============
                      /// Details price
                      /// ===============
                      const SaleTotalWidget(),

                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}