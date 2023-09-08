import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pos_application_mobile/app/extensions/string_extention.dart';
import 'package:pos_application_mobile/data/payloads/cloth_price_type_payload.dart';
import 'package:pos_application_mobile/presentation/app/cloth_price_type/controller/cloth_price_type_controller.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_bottom/pam_bottom.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_form/pam_form.dart';

/// Type for widget ClothPriceTypeFormScreen
enum ClothPriceTypeFormScreenType { store, update }

/// customer type Form Screen
///
/// This `ClothPriceTypeFormScreen` widget for handling form for created or updated customer type
/// and this widget has parameters that are optional where this widget has key
/// store and required when this widget has type updated.
///
/// Parameters navigation:
/// - `data`: A [ClothPriceTypePayload] object usually use for filled field form and widget
///           type updated.
///
/// Parameters:
/// - `type`: A [ClothPriceTypeFormScreenType] to determine what to do
class ClothPriceTypeFormScreen extends GetView<ClothPriceTypeController> {
  final ClothPriceTypeFormScreenType type;

  ClothPriceTypeFormScreen({super.key, this.type = ClothPriceTypeFormScreenType.store});

  final _formKey = GlobalKey<FormState>();

  /// form state field
  final Rx<String> name = "".obs;
  final Rx<String> description = "".obs;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    late String typeFormTitle = (type == ClothPriceTypeFormScreenType.store ? "store" : "update").tr;
    typeFormTitle = "$typeFormTitle ${"cloth price type".tr}".toCapitalize();

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
                PAMFormTextFieldWidget(
                  onSaved: (newValue) => name.value = newValue!,
                  initialValue: type == ClothPriceTypeFormScreenType.update && Get.arguments != null
                    ? Get.arguments["data"]?.name
                    : "",
                  labelText: "name".tr.toCapitalize(),
                  hintText: "name".tr.toCapitalize(),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "${"name".tr} ${"required".tr}".toCapitalize();
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                PAMFormTextFieldWidget(
                  onSaved: (newValue) => description.value = newValue!,
                  initialValue: type == ClothPriceTypeFormScreenType.update
                    ? Get.arguments["data"].description
                    : "",
                  labelText: "description".tr.toCapitalize(),
                  hintText: "description".tr.toCapitalize(),
                  maxLines: 5,
                ),
                const SizedBox(height: 50),
                PAMBottom(
                  title: typeFormTitle,
                  isLoading: false,
                  borderRadius: BorderRadius.circular(10),
                  onTab: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      
                      final ClothPriceTypePayload paylaod = ClothPriceTypePayload(
                        id: Get.arguments?["data"].id ?? "",
                        name: name.value,
                        description: description.value
                      );

                      // handling action 
                      if (type == ClothPriceTypeFormScreenType.store) controller.storeData(paylaod);
                      if (type == ClothPriceTypeFormScreenType.update) controller.updateData(paylaod);
                
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
