import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:pos_application_mobile/app/config/routes/app_screens.dart';
import 'package:pos_application_mobile/app/extensions/string_extention.dart';
import 'package:pos_application_mobile/data/payloads/user_payload.dart';
import 'package:pos_application_mobile/presentation/app/user/user.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_form/pam_form.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_list_scroll/pam_list_scroll.dart';

class UserScreen extends GetView<UserController> {
  const UserScreen({super.key});

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
                hintText: "search user".tr.toCapitalize(),
                decoration: const BoxDecoration(),
                onChanged: controller.searchDataUser,
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

  Widget _buildListUser() {
    return Obx(() {
      if (controller.isLoading && controller.dataUser.isEmpty) {
        return const Expanded(
          child: Center(
          child: CircularProgressIndicator(),
        ));
      }
      return Expanded(
        child: PAMListScroll(
          padding: const EdgeInsets.symmetric(vertical: 20),
          onRefresh: () => controller.fetchDataUser(refresh: true),
          itemCount: controller.dataUser.length,
          scrollToRefresh: controller.currentPage == controller.totalPage ? null : controller.fetchDataUser,
          itemBuilder: (context, index) {
            return Container(
              clipBehavior: Clip.hardEdge,
              margin: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10)
              ),
              child: Slidable(
                key: Key("${controller.dataUser[index]}"),
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
                        Get.to(UserFormScreen(type: UserFormScreenType.update),
                          binding: UserBinding(),
                          arguments: {
                            "data": UserPaylaod(
                              id: controller.dataUser[index].id ?? '',
                              email: controller.dataUser[index].email ?? '',
                              gender: controller.dataUser[index].gender ?? '',
                              name: controller.dataUser[index].name ?? '',
                              password: '',
                              role: controller.dataUser[index].role ?? ''
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
                        controller.userDelete(controller.dataUser[index].id!);
                      },
                      backgroundColor: Colors.redAccent,
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                    )
                  ],
                ),
                child: Card(
                  margin: EdgeInsets.zero,
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 14
                    ),
                    dense: true,
                    title: Text(controller.dataUser[index].name!.toCapitalize()),
                    tileColor: Colors.white,
                    subtitle: Text("${controller.dataUser[index].role}".toCapitalize()),
                    leading: Container(
                      alignment: Alignment.center,
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: const Icon(Icons.person_add_alt_1_rounded, color: Colors.white),
                    ),
                  ),
                )
              ),
            );
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
        title: Text(
          "user".tr.toCapitalize(),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            /* build list view */
            _buildHeader(),
            _buildListUser()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Get.toNamed(Routes.userForm);
          if (result is String) {
            controller.fetchDataUser(refresh: true);
          }
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}