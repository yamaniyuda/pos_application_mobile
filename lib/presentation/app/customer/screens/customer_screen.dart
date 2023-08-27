// ignore_for_file: unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pos_application_mobile/app/config/routes/app_screens.dart';
import 'package:pos_application_mobile/app/extensions/string_extention.dart';
import 'package:pos_application_mobile/presentation/app/customer/customer.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_form/pam_form.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_list_scroll/pam_list_scroll.dart';

class CustomerScreen extends GetView<CustomerController> {
  const CustomerScreen({super.key});

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
                hintText: "${"search".tr} ${"customer".tr}".toCapitalize(),
                decoration: const BoxDecoration(),
                onChanged: controller.searchDataCustomer,
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

  Widget _buildListCustomer() {
    return Obx(() {
      if (controller.isLoading && controller.dataCustomer.isEmpty) {
        return const Expanded(
          child: Center(
          child: CircularProgressIndicator(),
        ));
      }
      return Expanded(
        child: PAMListScroll(
          padding: const EdgeInsets.symmetric(vertical: 20),
          onRefresh: () => controller.fetchDataCustomer(refresh: true),
          itemCount: controller.dataCustomer.length,
          scrollToRefresh: controller.currentPage == controller.totalPage ? null : controller.fetchDataCustomer,
          itemBuilder: (context, index) {
            return Container(
              clipBehavior: Clip.hardEdge,
              margin: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10)
              ),
              child: Slidable(
                key: Key("${controller.dataCustomer[index]}"),
                closeOnScroll: false,
                endActionPane: controller.showSuperAccess
                  ? ActionPane(
                      extentRatio: 0.4,
                      motion: const ScrollMotion(),
                      dismissible: DismissiblePane(onDismissed: () {}),
                      dragDismissible: false,
                      openThreshold: .1,
                      children: [
                        
                        /// =============
                        /// Update action
                        /// =============
                        SlidableAction(
                          onPressed: (context) {
                            Get.to(CustomerFormScreen(type: CustomerFormScreenType.update),
                              binding: CustomerBinding(),
                              arguments: {
                                "data": controller.dataCustomer[index]
                              }
                            );
                          },
                          backgroundColor: const Color.fromARGB(255, 253, 207, 2),
                          foregroundColor: Colors.white,
                          icon: Icons.edit,
                        ),

                        /// =============
                        /// delete action
                        /// =============
                        SlidableAction(
                          onPressed: (context) {
                            controller.customerDelete(controller.dataCustomer[index].id!);
                          },
                          backgroundColor: Colors.redAccent,
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                        )
                      ]
                    )
                  : null,

                child: Card(
                  margin: EdgeInsets.zero,
                  child: ListTile(
                    trailing: const Icon(Icons.density_medium_rounded),
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
                      child: const Icon(Icons.lock_person_sharp, color: Colors.white),
                    ),
                    dense: true,
                    title: Text(
                      "${controller.dataCustomer[index].name!} ${controller.dataCustomer[index].customerType?.name != null ? "(${controller.dataCustomer[index].customerType!.name})" : ""}".toCapitalize()
                    ),
                    tileColor: Colors.white,
                    subtitle: Text("${controller.dataCustomer[index].email ?? "-"}".toCapitalize()),
                    onTap: () {
                      Get.bottomSheet(
                        SizedBox(
                          height: Get.height * .7,
                          child: Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              Positioned(
                                top: 50,
                                child: Container(
                                  width: Get.width,
                                  height: 500,
                                  padding: const EdgeInsets.all(50),
                                  decoration:  const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20)
                                    )
                                  ),
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 20),
                                      Text(
                                        controller.dataCustomer[index].name! +
                                        (controller.dataCustomer[index]
                                                        .customerType?.name !=
                                                    null
                                                ? " (${controller.dataCustomer[index].customerType?.name})"
                                                : "")
                                            .toCapitalize(),
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.lato(
                                          fontSize: 20,
                                        ),
                                      ),
                                      Text(
                                        "${controller.dataCustomer[index].email ?? "-"}",
                                        style: GoogleFonts.lato(
                                          color: Colors.black54.withOpacity(0.5)
                                        ),
                                      ),
                                      Text(
                                        controller.dataCustomer[index].phoneNumber!.toCapitalize(),
                                        style: GoogleFonts.lato(
                                          color: Colors.black54.withOpacity(0.5)
                                        ),
                                      ),
                                      const SizedBox(height: 30),


                                      /// =====================
                                      /// Province show section
                                      /// =====================
                                      SizedBox(
                                        width: double.infinity,
                                        child: Row(
                                          children: [
                                            Text("province".tr.toCapitalize()),
                                            const Spacer(),
                                            Text(controller.dataCustomer[index].province?.name ?? "-")
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 20),


                                      /// ====================
                                      /// Regency show section
                                      /// ====================
                                      SizedBox(
                                        width: double.infinity,
                                        child: Row(
                                          children: [
                                            Text("regency".tr.toCapitalize()),
                                            const Spacer(),
                                            Text(controller.dataCustomer[index].regency?.name ?? "-")
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 20),


                                      /// =====================
                                      /// District show section
                                      /// =====================
                                      SizedBox(
                                        width: double.infinity,
                                        child: Row(
                                          children: [
                                            Text("district".tr.toCapitalize()),
                                            const Spacer(),
                                            Text(controller.dataCustomer[index].district?.name ?? "-")
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 20),


                                      /// ====================
                                      /// Village show section
                                      /// ====================
                                      SizedBox(
                                        width: double.infinity,
                                        child: Row(
                                          children: [
                                            Text("village".tr.toCapitalize()),
                                            const Spacer(),
                                            Text(controller.dataCustomer[index].village?.name ?? "-")
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 20),


                                      /// ====================
                                      /// Address show section
                                      /// ====================
                                      SizedBox(
                                        width: double.infinity,
                                        child: Row(
                                          children: [
                                            Text("address".tr.toCapitalize()),
                                            const Spacer(),
                                            Text(controller.dataCustomer[index].address ?? "-")
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: const Color(0xff272829),
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: const Icon(
                                    Icons.lock_person_sharp, 
                                    color: Colors.white,
                                    size: 50,
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      );
                    },
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
          final result = await Get.toNamed(Routes.customerForm);
          if (result is String) {
            controller.fetchDataCustomer(refresh: true);
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
          "customer".tr.toCapitalize(),
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