import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:pos_application_mobile/app/config/routes/app_screens.dart';
import 'package:pos_application_mobile/app/extensions/string_extention.dart';
import 'package:pos_application_mobile/presentation/app/color/controllers/color_binding.dart';
import 'package:pos_application_mobile/presentation/app/color/controllers/color_controller.dart';
import 'package:pos_application_mobile/presentation/app/color/screens/color_form_screen.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_form/pam_form.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_list_scroll/pam_list_scroll.dart';

class ColorScreen extends GetView<ColorController> {
  const ColorScreen({super.key});

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
                hintText: "search color".tr.toCapitalize(),
                decoration: const BoxDecoration(),
                onChanged: controller.searchDataColor,
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

  List<Widget> _supperAccessListAction(int index, Color colorLeading) {
    if (controller.showSuperAccess) {
      return [
        SlidableAction(
          onPressed: (context) {
            Get.to(ColorFormScreen(type: ColorFormScreenType.update),
              binding: ColorBinding(),
              arguments: {
                "id": controller.dataColors[index].id,
                "name": controller.dataColors[index].name,
                "description": controller.dataColors[index].description,
                "codeHexa": colorLeading
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
            controller.colorDelete(controller.dataColors[index].id!);
          },
          backgroundColor: Colors.redAccent,
          foregroundColor: Colors.white,
          icon: Icons.delete,
        )
      ];
    }
    return [];
  }

  Widget _buildListColor() {
    return Obx(() {
      if (controller.isLoading && controller.dataColors.isEmpty) {
        return const Expanded(
          child: Center(
          child: CircularProgressIndicator(),
        ));
      }
      return Expanded(
        child: PAMListScroll(
          padding: const EdgeInsets.symmetric(vertical: 20),
          onRefresh: () => controller.fetchDataColor(refresh: true),
          itemCount: controller.dataColors.length,
          scrollToRefresh: controller.currentPage == controller.totalPage ? null : controller.fetchDataColor,
          itemBuilder: (context, index) {
            Color colorLeading;
            try {
              colorLeading = Color(
                int.parse("#${controller.dataColors[index].codeHexa ?? 'ffffff'}".substring(1, 7), radix: 16) + 0xFF000000
              );
            } catch (_) {
              colorLeading = Color(
                int.parse("#ffffff'".substring(1, 7), radix: 16) + 0xFF000000
              );
            }
            
            double luminance = colorLeading.computeLuminance();
            Color textColor = luminance > 0.5 ? Colors.black : Colors.white;

            return Container(
              clipBehavior: Clip.hardEdge,
              margin: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10)
              ),
              child: Slidable(
                key: Key("${controller.dataColors[index]}"),
                closeOnScroll: false,
                endActionPane: controller.showSuperAccess
                  ? ActionPane(
                      extentRatio: 0.4,
                      motion: const ScrollMotion(),
                      dismissible: DismissiblePane(onDismissed: () {}),
                      dragDismissible: false,
                      openThreshold: .1,
                      children: _supperAccessListAction(index, colorLeading)
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
                        color: colorLeading,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Icon(Icons.color_lens, color: textColor),
                    ),
                    dense: true,
                    title: Text(controller.dataColors[index].name!.toCapitalize()),
                    tileColor: Colors.white,
                    subtitle: Text((controller.dataColors[index].description ?? "-").toCapitalize()),
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
          final result = await Get.toNamed(Routes.colorForm);
          if (result is String) {
            controller.fetchDataColor(refresh: true);
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
          "color".tr.toCapitalize(),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            /* build list view */
            _buildHeader(),
            _buildListColor()
          ],
        ),
      ),
      floatingActionButton: _buildButtonAdd()
    );
  }
}
