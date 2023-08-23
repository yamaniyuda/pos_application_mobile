import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:pos_application_mobile/app/config/routes/app_screens.dart';
import 'package:pos_application_mobile/app/extensions/string_extention.dart';
import 'package:pos_application_mobile/data/payloads/customer_type_payload.dart';
import 'package:pos_application_mobile/presentation/app/customer_type/customer_type.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_form/pam_form.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_list_scroll/pam_list_scroll.dart';

class CustomerTypeScreen extends GetView<CustomerTypeController> {
  const CustomerTypeScreen({super.key});

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
                hintText: "${"search".tr} ${"customer type".tr}".toCapitalize(),
                decoration: const BoxDecoration(),
                onChanged: controller.searchDataCustomerType,
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
      if (controller.isLoading && controller.dataCustomerType.isEmpty) {
        return const Expanded(
          child: Center(
          child: CircularProgressIndicator(),
        ));
      }

      return Expanded(
        child: PAMListScroll(
          padding: const EdgeInsets.symmetric(vertical: 20),
          onRefresh: () => controller.fetchDataCustomerType(refresh: true),
          itemCount: controller.dataCustomerType.length,
          scrollToRefresh: controller.currentPage == controller.totalPage ? null : controller.fetchDataCustomerType,
          itemBuilder: (context, index) {
            return Container(
              clipBehavior: Clip.hardEdge,
              margin: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 5),
              decoration: const BoxDecoration(),
              child: Slidable(
                key: Key("${controller.dataCustomerType[index]}"),
                closeOnScroll: false,
                endActionPane: controller.showSuperAccess
                  ? ActionPane(
                      extentRatio: 0.4,
                      motion: const ScrollMotion(),
                      dismissible: DismissiblePane(onDismissed: () {}),
                      dragDismissible: false,
                      openThreshold: .1,
                      children: [

                        // update action
                        SlidableAction(
                          onPressed: (context) {
                            Get.to(CustomerTypeFormScreen(type: CustomerTypeFormScreenType.update),
                              binding: CustomerTypeBinding(),
                              arguments: {
                                "data": CustomerTypePayload(
                                  id: controller.dataCustomerType[index].id ?? '',
                                  name: controller.dataCustomerType[index].name ?? '',
                                  description: controller.dataCustomerType[index].description ?? ''
                                )
                              }
                            );
                          },
                          backgroundColor: const Color.fromARGB(255, 253, 207, 2),
                          foregroundColor: Colors.white,
                          icon: Icons.edit,
                        ),

                        // delete action
                        SlidableAction(
                          onPressed: (context) {
                            controller.customerTypeDelete(controller.dataCustomerType[index].id!);
                          },
                          backgroundColor: Colors.redAccent,
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                        )
                      ],
                    )
                  : null,


                child: ListTile(
                  leading: Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: const Icon(Icons.manage_accounts, color: Colors.white),
                  ),
                  dense: true,
                  title: Text(controller.dataCustomerType[index].name!.toCapitalize()),
                  tileColor: Colors.white,
                  subtitle: Text((controller.dataCustomerType[index].description ?? "-").toCapitalize()),
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
          final result = await Get.toNamed(Routes.customerTypeForm);
          if (result is String) {
            controller.fetchDataCustomerType(refresh: true);
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
          "customer type".tr.toCapitalize(),
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