import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pos_application_mobile/app/extensions/string_extention.dart';
import 'package:pos_application_mobile/data/payloads/customer_payload.dart';
import 'package:pos_application_mobile/presentation/app/customer/controllers/customer_controller.dart';
import 'package:pos_application_mobile/presentation/app/customer/screens/search_district_screen.dart';
import 'package:pos_application_mobile/presentation/app/customer/screens/search_provincy_screen.dart';
import 'package:pos_application_mobile/presentation/app/customer/screens/search_regency_screen.dart';
import 'package:pos_application_mobile/presentation/app/customer/screens/search_village_screen.dart';
import 'package:pos_application_mobile/presentation/app/customer/screens/select_option_customer_type_screen.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_bottom/pam_bottom.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_form/pam_form.dart';

/// Type for widget CustomerFormScreen
enum CustomerFormScreenType { store, update }

/// customer type Form Screen
///
/// This `CustomerFormScreen` widget for handling form for created or updated customer type
/// and this widget has parameters that are optional where this widget has key
/// store and required when this widget has type updated.
///
/// Parameters navigation:
/// - `data`: A [CustomerEntity] object usually use for filled field form and widget
///           type updated.
///
/// Parameters:
/// - `type`: A [CustomerFormScreenType] to determine what to do
class CustomerFormScreen extends GetView<CustomerController> {
  final CustomerFormScreenType type;

  CustomerFormScreen({super.key, this.type = CustomerFormScreenType.store});

  final _formKey = GlobalKey<FormState>();

  /// form state field
  final Rx<String> name = "".obs;
  final Rx<String> customerType = "".obs;
  final Rx<String> email = "".obs;
  final Rx<String> address = "".obs;
  final Rx<String> phoneNumber = "".obs;
  final Rx<String> provinceId = "".obs;
  final Rx<String> regencyId = "".obs;
  final Rx<String> districtId = "".obs;
  final Rx<String> villageId = "".obs;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    late String typeFormTitle = (type == CustomerFormScreenType.store ? "store" : "update").tr.toCapitalize();
    typeFormTitle = "$typeFormTitle ${"customer".tr}".toCapitalize();

    // UI handling when type form is updated
    provinceId.value = provinceId.value != "" ? provinceId.value : Get.arguments?["data"]?.province?.id ?? "";
    regencyId.value = regencyId.value != "" ? regencyId.value : Get.arguments?["data"]?.regency?.id ?? "";
    districtId.value = districtId.value != "" ? districtId.value : Get.arguments?["data"]?.district?.id ?? "";

    return Scaffold(
      appBar: AppBar(
        title: Text(typeFormTitle),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // name
                PAMFormTextFieldWidget(
                  onSaved: (newValue) => name.value = newValue!,
                  initialValue: type == CustomerFormScreenType.update && Get.arguments != null
                    ? Get.arguments["data"]?.name
                    : "",
                  labelText: "name".tr.toCapitalize(),
                  hintText: "name".tr.toCapitalize(),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "customer type is required".tr.toCapitalize();
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),

                // customer type
                PAMFormTextFieldWidget(
                  onSaved: (newValue) => customerType.value = newValue!,
                  initialValue: type == CustomerFormScreenType.update && Get.arguments != null
                    ? Get.arguments["data"]?.customerType?.name
                    : "",
                  hiddenValue: type == CustomerFormScreenType.update && Get.arguments != null
                    ? Get.arguments["data"]?.customerType?.id
                    : "",
                  screen: SelectOptionCustomerTypeScreen(),
                  labelText: "customer type".tr.toCapitalize(),
                  hintText: "customer type".tr.toCapitalize(),
                ),
                const SizedBox(height: 10),

                // email
                PAMFormTextFieldWidget(
                  onSaved: (newValue) => email.value = newValue!,
                  initialValue: type == CustomerFormScreenType.update && Get.arguments != null
                    ? Get.arguments["data"]?.email
                    : "",
                  labelText: "email".tr.toCapitalize(),
                  hintText: "email".tr.toCapitalize(),
                ),
                const SizedBox(height: 10),

                // phone number
                PAMFormTextFieldWidget(
                  onSaved: (newValue) => phoneNumber.value = newValue!,
                  initialValue: type == CustomerFormScreenType.update  && Get.arguments != null
                    ? Get.arguments["data"]?.phoneNumber
                    : "",
                  labelText: "phone number".tr.toCapitalize(),
                  hintText: "phone number".tr.toCapitalize(),
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 10),

                ///
                /// Province form field
                ///
                PAMFormTextFieldWidget(
                  onSaved: (newValue) => provinceId.value = newValue!,
                  initialValue: type == CustomerFormScreenType.update && Get.arguments != null
                    ? Get.arguments["data"]?.province?.name
                    : "",
                  hiddenValue: type == CustomerFormScreenType.update && Get.arguments != null
                    ? Get.arguments["data"]?.province?.id
                    : "",
                  labelText: "province".tr.toCapitalize(),
                  hintText: "province".tr.toCapitalize(),
                  screen: SearchProvincyScreen(),
                  onChanged: (String? value) {
                    provinceId.value = value!;
                  },
                ),
                const SizedBox(height: 10),

                ///
                /// Regency Field Form
                ///
                PAMFormTextFieldWidget(
                  onSaved: (newValue) => regencyId.value = newValue!,
                  initialValue: type == CustomerFormScreenType.update && Get.arguments != null
                    ? Get.arguments["data"]?.regency?.name
                    : "",
                  hiddenValue: type == CustomerFormScreenType.update && Get.arguments != null
                    ? Get.arguments["data"]?.regency?.id
                    : "",
                  labelText: "regency".tr.toCapitalize(),
                  hintText: "regency".tr.toCapitalize(),
                  onChanged: (String? value) => regencyId.value = value ?? "",
                  screen: Obx(() => SearchRegencyScreen(
                    provincyId: provinceId.value,
                  ))
                ),
                const SizedBox(height: 10),

                ///
                /// District Field Form
                ///
                PAMFormTextFieldWidget(
                  onSaved: (newValue) => districtId.value = newValue!,
                  initialValue: type == CustomerFormScreenType.update && Get.arguments != null
                    ? Get.arguments["data"]?.district?.name
                    : "",
                  hiddenValue: type == CustomerFormScreenType.update && Get.arguments != null
                    ? Get.arguments["data"]?.district?.id
                    : "",
                  labelText: "district".tr.toCapitalize(),
                  hintText: "district".tr.toCapitalize(),
                  onChanged: (String? value) => districtId.value = value!,
                  screen: Obx(() => SearchDistrictScreen(
                    regencyId: regencyId.value,
                  ))
                ),
                const SizedBox(height: 10),

                ///
                /// Village Field Form
                ///
                PAMFormTextFieldWidget(
                  onSaved: (newValue) => villageId.value = newValue!,
                  initialValue: type == CustomerFormScreenType.update && Get.arguments != null
                    ? Get.arguments["data"]?.village?.name
                    : "",
                  hiddenValue: type == CustomerFormScreenType.update && Get.arguments != null
                    ? Get.arguments["data"]?.village?.id
                    : "",
                  labelText: "village".tr.toCapitalize(),
                  hintText: "village".tr.toCapitalize(),
                  onChanged: (String? value) => villageId.value = value!,
                  screen: Obx(() => SearchVillageScreen(
                    districtId: districtId.value,
                  ))
                ),
                const SizedBox(height: 10),
                
                PAMFormTextFieldWidget(
                  onSaved: (newValue) => address.value = newValue!,
                  initialValue: type == CustomerFormScreenType.update && Get.arguments != null
                    ? Get.arguments["data"]?.address
                    : "",
                  labelText: "address".tr.toCapitalize(),
                  hintText: "address".tr.toCapitalize(),
                  maxLines: 5,
                ),
                const SizedBox(height: 10),

                PAMBottom(
                  title: typeFormTitle,
                  isLoading: false,
                  borderRadius: BorderRadius.circular(10),
                  onTab: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      
                      /// binding to object class
                      final CustomerPayload paylaod = CustomerPayload(
                        id: Get.arguments?["data"]?.id ?? "",
                        name: name.value,
                        customerCategoryId: customerType.value,
                        address: address.value,
                        districtId: districtId.value,
                        email: email.value,
                        phoneNumber: phoneNumber.value,
                        provinceId: provinceId.value,
                        regencyId: regencyId.value,
                        villageId: villageId.value
                      );

                      // handling action 
                      if (type == CustomerFormScreenType.store) controller.customerStore(paylaod);
                      if (type == CustomerFormScreenType.update) controller.customerUpdate(paylaod);
                
                    }
                  },
                )
              ],
            ),
          )
        )
      ),
    );
  }
}
