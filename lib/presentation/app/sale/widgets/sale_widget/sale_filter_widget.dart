// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pos_application_mobile/app/extensions/string_extention.dart';
import 'package:pos_application_mobile/presentation/app/sale/controllers/sale_controller.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_bottom/pam_bottom.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_form/pam_form_optoins_widget.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class SaleFilterWidget extends StatelessWidget {
  SaleFilterWidget({super.key});

  final controller = Get.find<SaleController>();

  final String placeholderCreatedBy = "filter ${"sale".tr}".toCapitalize();

  /// save state for created by filter
  RxString createdByFiltering = "".obs;

  RxBool showFilterCreated = true.obs;

  /// controller for date range
  DateRangePickerController dateRangePickerController = DateRangePickerController();


  /// Handling Reset Handling.
  void _resetHandling() {
    dateRangePickerController.selectedRange = null;
    createdByFiltering.value = "";
    showFilterCreated.value = false;
    
    Timer(const Duration(milliseconds: 200), () {
      showFilterCreated.value = true;
    });

    // timer.cancel();

    // showFilterCreated.value = true;
    controller.searchData({});
  }
  


  /// Handling Done.
  void _doneHandling() {
    Map<String, String> queryParams = {};

    if (createdByFiltering.value != "") {
      queryParams.addAll({
        "created_by": createdByFiltering.value
      });
    }

    if (dateRangePickerController.selectedRange != null) {
      DateTime startDate = dateRangePickerController.selectedRange!.startDate!;
      DateTime endDate = dateRangePickerController.selectedRange!.endDate!;

      queryParams.addAll({ 
        "start_date": "${startDate.year}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "end_date": "${endDate.year}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}"
      });
    }

    controller.searchData(queryParams);
    Get.back();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * .8,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10)
        )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              "filter ${"sale".tr}".toCapitalize(),
              style: GoogleFonts.lato(
                fontWeight: FontWeight.bold,
                fontSize: 18
              ),
            ),
          ),


          /// ==================
          /// Created By Filter
          /// ==================
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10
                  ),
                  child: Obx(() {
                    if (showFilterCreated.value == false) {
                      return Container();
                    }

                    return PAMFormOptionsWidget(
                      context: context,
                      label: "created by".tr.toCapitalize(), 
                      labelStyle: GoogleFonts.lato(
                        fontSize: 16
                      ),
                      onChange: (p0) => createdByFiltering.value = p0!,
                      initialValue: createdByFiltering.value == "" ? null : createdByFiltering.value,
                      options: [
                        PAMFormOptionItemWidget(
                          label: "owner".tr.toCapitalize(), 
                          value: "owner"
                        ),
                        PAMFormOptionItemWidget(
                          label: "gudang".tr.toCapitalize(), 
                          value: "gudang"
                        ),
                        PAMFormOptionItemWidget(
                          label: "reseller".tr.toCapitalize(), 
                          value: "reseller"
                        ),
                        PAMFormOptionItemWidget(
                          label: "kasir".tr.toCapitalize(), 
                          value: "kasir"
                        ),
                        PAMFormOptionItemWidget(
                          label: "manager".tr.toCapitalize(), 
                          value: "manager"
                        )
                      ]
                    );
                  })
                ),
              ],
            )
          ),


          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Divider(
              height: 40,
              color: Colors.black45,
            ),
          ),


          /// ============
          /// Date Filter
          /// ============
          Container(
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "filter ${"date".tr}".toCapitalize(),
                    style: GoogleFonts.lato(
                      fontSize: 16
                    ),
                  ),
                ),
                Obx(() {
                  if (showFilterCreated.value == false) {
                    return Container();
                  }

                  return SfDateRangePicker(
                    onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                      // print(args.value.startDate);
                    },
                    controller: dateRangePickerController,
                    selectionMode: DateRangePickerSelectionMode.range,
                  );
                })
              ],
            ),
          ),


          /// ================
          /// Bottom Handling
          /// ================
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20
              ),
              alignment: Alignment.bottomCenter,
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                    child: PAMBottom(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10)
                      ),
                      color: Theme.of(context).primaryColor.withOpacity(0.2),
                      fontColor: Theme.of(context).primaryColor,
                      title: "reset",
                      onTab: _resetHandling,
                      isLoading: false,
                    )
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: PAMBottom(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10)
                      ),
                      title: "done",
                      onTab: _doneHandling,
                      isLoading: false,
                    )
                  )
                ],
              ),
            ),
          )
        ],
      )
    );
  }
}
