import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pos_application_mobile/app/extensions/string_extention.dart';
import 'package:pos_application_mobile/presentation/app/customer/controllers/search_district_controller.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_bottom/pam_bottom.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_form/pam_form.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_list_scroll/pam_list_scroll.dart';

class SearchDistrictScreen extends StatelessWidget {
  final String provincyId;
  
  final SearchDistrictController controller = Get.put(SearchDistrictController());
  
  SearchDistrictScreen({
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
                hintText: "${"search".tr} ${"district".tr}".toCapitalize(),
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
      if (controller.isLoading && controller.districtDatas.isEmpty) {
        return const Expanded(
          child: Center(
          child: CircularProgressIndicator(),
        ));
      }
      return Expanded(
        child: PAMListScroll(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          onRefresh: () => controller.fetchDataCustomer(refresh: true),
          itemCount: controller.districtDatas.length,
          scrollToRefresh: controller.currentPage == controller.totalPage ? null : controller.fetchDataCustomer,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () => controller.changeRadioSelection(
                controller.districtDatas[index].id!,
                controller.districtDatas[index].name!
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 4),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: index != (controller.districtDatas.length - 1)
                          ? Colors.black54
                          : Colors.transparent
                    )
                  )
                ),
                child: Obx(() => Row(
                  children: [
                    Radio(
                      value: controller.districtDatas[index].id as String,
                      groupValue: controller.chooseValue,
                      onChanged: (String? value) {
                        controller.changeRadioSelection(
                          value!,
                          controller.districtDatas[index].name!
                        );
                      }
                    ),
                    Flexible(
                      child: Text(
                        controller.districtDatas[index].name!,
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
    controller.setDistrictId = provincyId;
    controller.fetchDataCustomer(queryParameters: {
      "regency_id": provincyId
    },
      refresh: true
    );
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "district".tr.toCapitalize(),
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
                title: "${"choose".tr} ${"district".tr}".toCapitalize(),
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