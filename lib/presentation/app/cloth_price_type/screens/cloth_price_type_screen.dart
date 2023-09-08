import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:pos_application_mobile/app/config/routes/app_screens.dart';
import 'package:pos_application_mobile/app/extensions/string_extention.dart';
import 'package:pos_application_mobile/presentation/app/cloth_price_type/cloth_price_type.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_form/pam_form.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_list_scroll/pam_list_scroll.dart';

class ClothPriceTypeScreen extends GetView<ClothPriceTypeController> {
  const ClothPriceTypeScreen({super.key});

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
                hintText: "${"search".tr} ${"cloth price type".tr}".toCapitalize(),
                decoration: const BoxDecoration(),
                onChanged: controller.searchData,
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
          padding: const EdgeInsets.symmetric(vertical: 20),
          onRefresh: () => controller.fetchData(refresh: true),
          itemCount: controller.data.length,
          scrollToRefresh: controller.currentPage == controller.totalPage ? null : controller.fetchData,
          itemBuilder: (context, index) {
            return Container(
              clipBehavior: Clip.hardEdge,
              margin: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10)
              ),
              child: Slidable(
                key: Key("${controller.data[index]}"),
                closeOnScroll: false,
                endActionPane: controller.showSuperAccess
                  ? ActionPane(
                      extentRatio: 0.4,
                      motion: const ScrollMotion(),
                      dismissible: DismissiblePane(onDismissed: () {}),
                      dragDismissible: false,
                      openThreshold: .1,
                      children: [
                        
                        /// ==============
                        /// Update action
                        /// ==============
                        SlidableAction(
                          onPressed: (context) {
                            Get.to(ClothPriceTypeFormScreen(type: ClothPriceTypeFormScreenType.update),
                              binding: ClothPriceTypeBinding(),
                              arguments: {
                                "data": controller.data[index]
                              }
                            );
                          },
                          backgroundColor: const Color.fromARGB(255, 253, 207, 2),
                          foregroundColor: Colors.white,
                          icon: Icons.edit,
                        ),

                        /// =============
                        /// Delete action
                        /// =============
                        SlidableAction(
                          onPressed: (context) {
                            controller.deleteData(controller.data[index].id!);
                          },
                          backgroundColor: Colors.redAccent,
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                        )
                      ],
                    )
                  : null,


                child: Card(
                  margin: EdgeInsets.zero,
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 14
                    ),
                    leading: Container(
                      alignment: Alignment.center,
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: const Icon(Icons.discount_rounded, color: Colors.white),
                    ),
                    dense: true,
                    title: Text(controller.data[index].name!.toCapitalize()),
                    tileColor: Colors.white,
                    subtitle: Text((controller.data[index].description ?? "-").toCapitalize()),
                  ),
                ),
              ),
            );
          },
        )
      );
    });
  }

  Widget _buildButtonAdd() {
    if (controller.showSuperAccess) {
      return FloatingActionButton(
        onPressed: () async {
          final result = await Get.toNamed(Routes.clothPriceTypeForm);
          if (result is String) {
            controller.fetchData(refresh: true);
          }
        },
        backgroundColor: Theme.of(Get.context!).primaryColor,
        child: const Icon(Icons.add),
      );
    }
    return Container();
  }


  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "cloth price type".tr.toCapitalize(),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            /* build list view */
            _buildHeader(),
            _buildListCustomerType()
          ],
        ),
      ),
      floatingActionButton: _buildButtonAdd()
    );
  }
}