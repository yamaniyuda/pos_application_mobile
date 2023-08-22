import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:pos_application_mobile/app/config/routes/app_screens.dart';
import 'package:pos_application_mobile/app/extensions/string_extention.dart';
import 'package:pos_application_mobile/data/payloads/size_payload.dart';
import 'package:pos_application_mobile/presentation/app/size/size.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_form/pam_form.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_list_scroll/pam_list_scroll.dart';

class SizeScreen extends GetView<SizeController> {
  const SizeScreen({super.key});

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
                hintText: "search customer type".tr.toCapitalize(),
                decoration: const BoxDecoration(),
                onChanged: controller.searchdataSize,
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

  Widget _buildListsize() {
    return Obx(() {
      if (controller.isLoading && controller.dataSize.isEmpty) {
        return const Expanded(
          child: Center(
          child: CircularProgressIndicator(),
        ));
      }
      return Expanded(
        child: PAMListScroll(
          padding: const EdgeInsets.symmetric(vertical: 20),
          onRefresh: () => controller.fetchdataSize(refresh: true),
          itemCount: controller.dataSize.length,
          scrollToRefresh: controller.currentPage == controller.totalPage ? null : controller.fetchdataSize,
          itemBuilder: (context, index) {
            return Container(
              clipBehavior: Clip.hardEdge,
              margin: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 5),
              decoration: const BoxDecoration(),
              child: Slidable(
                key: Key("${controller.dataSize[index]}"),
                closeOnScroll: false,
                endActionPane: ActionPane(
                  extentRatio: 0.4,
                  motion: const ScrollMotion(),
                  dismissible: DismissiblePane(onDismissed: () {}),
                  dragDismissible: false,
                  openThreshold: .1,
                  children: [

                    // update action
                    SlidableAction(
                      onPressed: (context) {
                        Get.to(SizeFormScreen(type: SizeFormScreenType.update),
                          binding: SizeBinding(),
                          arguments: {
                            "data": SizePayload(
                              id: controller.dataSize[index].id ?? '',
                              name: controller.dataSize[index].name ?? '',
                              description: controller.dataSize[index].description ?? ''
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
                        controller.sizeDelete(controller.dataSize[index].id!);
                      },
                      backgroundColor: Colors.redAccent,
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                    )
                  ],
                ),
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
                  trailing: const Icon(Icons.density_medium_rounded),
                  dense: true,
                  title: Text(controller.dataSize[index].name!.toCapitalize()),
                  tileColor: Colors.white,
                  subtitle: Text("${controller.dataSize[index].description}".toCapitalize()),
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
          final result = await Get.toNamed(Routes.sizeForm);
          if (result is String) {
            controller.fetchdataSize(refresh: true);
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
          "size".tr.toCapitalize(),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            /* build list view */
            _buildHeader(),
            _buildListsize()
          ],
        ),
      ),
      floatingActionButton: _buildButtonAdd()
    );
  }
}