import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pos_application_mobile/app/extensions/string_extention.dart';
import 'package:pos_application_mobile/data/payloads/size_payload.dart';
import 'package:pos_application_mobile/presentation/app/size/size.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_bottom/pam_bottom.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_form/pam_form.dart';

/// Type for widget SizeFormScreen
enum SizeFormScreenType { store, update }

/// Size Form Screen
///
/// This `SizeFormScreen` widget for handling form for created or updated Size
/// and this widget has parameters that are optional where this widget has key
/// store and required when this widget has type updated.
///
/// Parameters navigation:
/// - `data`: A [SizePayload] object usually use for filled field form and widget
///           type updated.
///
/// Parameters:
/// - `type`: A [SizeFormScreenType] to determine what to do
class SizeFormScreen extends GetView<SizeController> {
  final SizeFormScreenType type;

  SizeFormScreen({super.key, this.type = SizeFormScreenType.store});

  final _formKey = GlobalKey<FormState>();

  /// form state field
  final Rx<String> name = "".obs;
  // final Rx<String> slug = "".obs;
  final Rx<String> description = "".obs;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    late String typeFormTitle = (type == SizeFormScreenType.store ? "store" : "update").tr;
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
                  initialValue: type == SizeFormScreenType.update && Get.arguments != null
                    ? Get.arguments["data"].name
                    : "",
                  labelText: "name".tr.toCapitalize(),
                  hintText: "name".tr.toCapitalize(),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Size is required".tr.toCapitalize();
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),

                // /// slug field
                // PAMFormTextFieldWidget(
                //   onSaved: (newValue) => slug.value = newValue!,
                //   initialValue: type == SizeFormScreenType.update && Get.arguments != null
                //     ? Get.arguments["data"].slug
                //     : "",
                //   labelText: "slug".tr.toCapitalize(),
                //   hintText: "slug".tr.toCapitalize(),
                // ),
                // const SizedBox(height: 10),

                /// description field
                PAMFormTextFieldWidget(
                  onSaved: (newValue) => description.value = newValue!,
                  initialValue: type == SizeFormScreenType.update && Get.arguments != null
                    ? Get.arguments["data"].description 
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
                      
                      final SizePayload paylaod = SizePayload(
                        id: Get.arguments?["data"].id ?? "",
                        name: name.value,
                        // slug: slug.value,
                        description: description.value
                      );

                      // handling action 
                      if (type == SizeFormScreenType.store) controller.sizeStore(paylaod);
                      if (type == SizeFormScreenType.update) controller.sizeUpdate(paylaod);
                
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
