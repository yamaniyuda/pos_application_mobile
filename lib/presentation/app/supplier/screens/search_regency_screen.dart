import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pos_application_mobile/app/extensions/string_extention.dart';
import 'package:pos_application_mobile/presentation/app/customer/controllers/search_regency_controller.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_bottom/pam_bottom.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_form/pam_form.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_list_scroll/pam_list_scroll.dart';

class SearchRegencyScreen extends StatelessWidget {
  final String provincyId;
  
  final SearchRegencyControlelr controller = Get.put(SearchRegencyControlelr());
  
  SearchRegencyScreen({
    super.key,
    required this.provincyId
  });

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
                hintText: "${"search".tr} ${"regency".tr}".toCapitalize(),
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
      if (controller.isLoading && controller.regencyDatas.isEmpty) {
        return const Expanded(
          child: Center(
          child: CircularProgressIndicator(),
        ));
      }
      return Expanded(
        child: PAMListScroll(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          onRefresh: () => controller.fetchDataCustomer(refresh: true),
          itemCount: controller.regencyDatas.length,
          scrollToRefresh: controller.currentPage == controller.totalPage ? null : controller.fetchDataCustomer,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () => controller.changeRadioSelection(
                controller.regencyDatas[index].id!,
                controller.regencyDatas[index].name!
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 4),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: index != (controller.regencyDatas.length - 1)
                          ? Colors.black54
                          : Colors.transparent
                    )
                  )
                ),
                child: Obx(() => Row(
                  children: [
                    Radio(
                      value: controller.regencyDatas[index].id as String,
                      groupValue: controller.chooseValue,
                      onChanged: (String? value) {
                        print("masuk klik");
                        print(controller.regencyDatas[index].name);
                        controller.changeRadioSelection(
                          value!,
                          controller.regencyDatas[index].name!
                        );
                      }
                    ),
                    Flexible(
                      child: Text(
                        controller.regencyDatas[index].name!,
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ))
              )
            );
          },
        )
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    /// trigger handling update ui
    controller.setProvincyId = provincyId;
    controller.fetchDataCustomer(queryParameters: {
      "province_id": provincyId
    },
      refresh: true
    );
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "regency".tr.toCapitalize(),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            /* build list view */
            _buildHeader(),
            _buildListCustomer(),
            Padding(
              padding: const EdgeInsets.all(20),
              child: PAMBottom(
                title: "${"choose".tr} ${"regency".tr}".toCapitalize(),
                isLoading: false,
                borderRadius: BorderRadius.circular(10),
                onTab: () async {
                  Get.back(result: {
                    "label": controller.chooseLabel,
                    "value": controller.chooseValue
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}