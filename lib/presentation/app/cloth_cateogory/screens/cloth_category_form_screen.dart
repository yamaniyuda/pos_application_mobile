import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pos_application_mobile/app/extensions/string_extention.dart';
import 'package:pos_application_mobile/data/payloads/cloth_category_payload.dart';
import 'package:pos_application_mobile/presentation/app/cloth_cateogory/cloth_category.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_bottom/pam_bottom.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_form/pam_form.dart';

/// Type for widget ClothCategoryFormScreen
enum ClothCategoryFormScreenType { store, update }

/// Size Form Screen
///
/// This `ClothCategoryFormScreen` widget for handling form for created or updated Size
/// and this widget has parameters that are optional where this widget has key
/// store and required when this widget has type updated.
///
/// Parameters navigation:
/// - `data`: A [ClothCategoryPayload] object usually use for filled field form and widget
///           type updated.
///
/// Parameters:
/// - `type`: A [ClothCategoryFormScreenType] to determine what to do
class ClothCategoryFormScreen extends GetView<ClothCategoryController> {
  final ClothCategoryFormScreenType type;

  ClothCategoryFormScreen({super.key, this.type = ClothCategoryFormScreenType.store});

  final _formKey = GlobalKey<FormState>();

  /// form state field
  final Rx<String> name = "".obs;
  final Rx<String> description = "".obs;

  final dynamic arguments = Get.arguments;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    late String typeFormTitle = (type == ClothCategoryFormScreenType.store ? "store" : "update").tr;
    typeFormTitle = "$typeFormTitle ${"size".tr}".toCapitalize();

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

                /// name field
                PAMFormTextFieldWidget(
                  onSaved: (newValue) => name.value = newValue!,
                  initialValue: type == ClothCategoryFormScreenType.update && Get.arguments != null
                    ? Get.arguments["data"].name
                    : "",
                  labelText: "name".tr.toCapitalize(),
                  hintText: "name".tr.toCapitalize(),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "${"size".tr} ${"required".tr}".toCapitalize();
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),

                /// description field
                PAMFormTextFieldWidget(
                  onSaved: (newValue) => description.value = newValue!,
                  initialValue: type == ClothCategoryFormScreenType.update && Get.arguments != null
                    ? Get.arguments["data"].description ?? ""
                    : "",
                  labelText: "description".tr.toCapitalize(),
                  hintText: "description".tr.toCapitalize(),
                  maxLines: 5,
                ),
                const SizedBox(height: 50),

                /// buttom 
                PAMBottom(
                  title: typeFormTitle,
                  isLoading: false,
                  borderRadius: BorderRadius.circular(10),
                  onTab: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      
                      final ClothCategoryPayload paylaod = ClothCategoryPayload(
                        id: Get.arguments?["data"].id ?? "",
                        name: name.value,
                        description: description.value
                      );

                      // handling action 
                      if (type == ClothCategoryFormScreenType.store) controller.clothCategoryStore(paylaod);
                      if (type == ClothCategoryFormScreenType.update) controller.clothCategoryUpdate(paylaod);
                
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
