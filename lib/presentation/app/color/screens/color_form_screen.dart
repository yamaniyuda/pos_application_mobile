import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:pos_application_mobile/app/extensions/string_extention.dart';
import 'package:pos_application_mobile/presentation/app/color/color.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_bottom/pam_bottom.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_form/pam_form.dart';

/// Define type for screen form color
enum ColorFormScreenType {
  store, update
}

/// Color Form Screen has a navigation arguments with Map type
/// 
/// Navigation Parameters:
/// - `id`: The unique identifier of the color to be updated.
/// - `name`: The name of color.
/// - `description`: The description of color.
/// - `codeHexa`: The code hexadecimal for representation of color.
class ColorFormScreen extends GetView<ColorController> {
  final ColorFormScreenType type;

  ColorFormScreen({
    super.key,
    this.type = ColorFormScreenType.store
  });

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    late String titleAppBar;

    if (type == ColorFormScreenType.store) {
      titleAppBar = "add color".tr.toCapitalize();
    } else {
      titleAppBar = "update color".tr.toCapitalize();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(titleAppBar),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  ColorPicker(
                    pickerColor: type == ColorFormScreenType.update
                      ? Get.arguments["codeHexa"] as Color
                      : controller.colorPicker,
                    onColorChanged: controller.setColorPicker,
                  ),
                  PAMFormTextFieldWidget(
                    initialValue: type == ColorFormScreenType.update
                      ? Get.arguments["name"]
                      : "",
                    hintText: "color name".tr.toCapitalize(),
                    onSaved: (String? value) =>
                    controller.setColorName = value!,
                  ),
                  const SizedBox(height: 12),
                  PAMFormTextFieldWidget(
                    initialValue: type == ColorFormScreenType.update
                      ? Get.arguments["description"]
                      : "",
                    hintText: "color description".tr.toCapitalize(),
                    maxLines: 5,
                    onSaved: (String? value) =>
                    controller.setColorDescription = value ?? "",
                  ),
                  const SizedBox(height: 24),
                  PAMBottom(
                    title: titleAppBar,
                    isLoading: false,
                    borderRadius: BorderRadius.circular(10),
                    onTab: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        
                        // handling action 
                        if (type == ColorFormScreenType.store) controller.colorStore();
                        if (type == ColorFormScreenType.update) controller.colorUpdate(Get.arguments["id"]);

                      }
                    },
                  ),
                ],
              ),
            ),
          )
      ),
    );
  }
}