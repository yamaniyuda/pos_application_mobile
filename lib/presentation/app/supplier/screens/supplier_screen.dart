import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:pos_application_mobile/app/config/routes/app_screens.dart';
import 'package:pos_application_mobile/app/extensions/string_extention.dart';
import 'package:pos_application_mobile/data/payloads/supplier_payload.dart';
import 'package:pos_application_mobile/presentation/app/supplier/supplier.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_form/pam_form.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_list_scroll/pam_list_scroll.dart';

class SupplierScreen extends GetView<SupplierController> {
  const SupplierScreen({super.key});

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
                hintText: "search supplier".tr.toCapitalize(),
                decoration: const BoxDecoration(),
                onChanged: controller.searchDataSupplier,
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

  List<Widget> _supperAccessListAction(int index) {
    if (controller.showSuperAccess) {
      return [
        SlidableAction(
              onPressed: (context) {
            Get.to(SupplierFormScreen(type: SupplierFormScreenType.update),
              binding: SupplierBinding(),
              arguments: {
                "data": SupplierPayload(
                  id: controller.dataSupplier[index].id ?? '',
                  name: controller.dataSupplier[index].name ?? '',
                  address: controller.dataSupplier[index].address ?? '',
                  districtId: controller.dataSupplier[index].districtId ?? '',
                  email: controller.dataSupplier[index].email ?? '',
                  phoneNumber: controller.dataSupplier[index].phoneNumber ?? '',
                  provinceId: controller.dataSupplier[index].provinceId ?? '',
                  regencyId: controller.dataSupplier[index].regencyId ?? '',
                  villageId: controller.dataSupplier[index].villageId ?? ''
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
            controller.supplierDelete(controller.dataSupplier[index].id!);
          },
          backgroundColor: Colors.redAccent,
          foregroundColor: Colors.white,
          icon: Icons.delete,
        )
      ];
    }
    return [];
  }

  Widget _buildListCustomer() {
    return Obx(() {
      if (controller.isLoading && controller.dataSupplier.isEmpty) {
        return const Expanded(
          child: Center(
          child: CircularProgressIndicator(),
        ));
      }
      return Expanded(
        child: PAMListScroll(
          padding: const EdgeInsets.symmetric(vertical: 20),
          onRefresh: () => controller.fetchDataSupplier(refresh: true),
          itemCount: controller.dataSupplier.length,
          scrollToRefresh: controller.currentPage == controller.totalPage ? null : controller.fetchDataSupplier,
          itemBuilder: (context, index) {
            return Container(
              clipBehavior: Clip.hardEdge,
              margin: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 5),
              decoration: const BoxDecoration(),
              child: Slidable(
                key: Key("${controller.dataSupplier[index]}"),
                closeOnScroll: false,
                endActionPane: controller.showSuperAccess 
                  ? ActionPane(
                    extentRatio: 0.4,
                    motion: const ScrollMotion(),
                    dismissible: DismissiblePane(onDismissed: () {}),
                    dragDismissible: false,
                    openThreshold: .1,
                    children: _supperAccessListAction(index)
                  ): null,
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
                  title: Text(controller.dataSupplier[index].name!.toCapitalize()),
                  tileColor: Colors.white,
                  subtitle: Text("${controller.dataSupplier[index].email}".toCapitalize()),
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
          final result = await Get.toNamed(Routes.supplierForm);
          if (result is String) {
            controller.fetchDataSupplier(refresh: true);
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
          "supplier".tr.toCapitalize(),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            /* build list view */
            _buildHeader(),
            _buildListCustomer()
          ],
        ),
      ),
      floatingActionButton: _buildButtonAdd()
    );
  }
}