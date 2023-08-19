import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pos_application_mobile/app/extensions/string_extention.dart';
import 'package:pos_application_mobile/app/services/auth_service.dart';
import 'package:pos_application_mobile/data/payloads/user_payload.dart';
import 'package:pos_application_mobile/presentation/app/user/user.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_bottom/pam_bottom.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_form/pam_form.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_form/pam_form_optoins_widget.dart';

/// Type for widget UserFormScreen
enum UserFormScreenType { store, update }

/// User Form Screen
///
/// This `UserFormScreen` widget for handling form for created or updated user
/// and this widget has parameters that are optional where this widget has key
/// store and required when this widget has type updated.
///
/// Parameters navigation:
/// - `data`: A [UserPaylaod] object usually use for filled field form and widget
///           type updated.
///
/// Parameters:
/// - `type`: A [UserFormScreenType] to determine what to do
class UserFormScreen extends GetView<UserController> {
  final UserFormScreenType type;

  UserFormScreen({super.key, this.type = UserFormScreenType.store});

  final _formKey = GlobalKey<FormState>();

  /// form state field
  final Rx<String> name = "".obs;
  final Rx<String> email = "".obs;
  final Rx<String> password = "".obs;
  final Rx<String> gender = "".obs;
  final Rx<String> role = "".obs;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    final String typeFormTitle = (type == UserFormScreenType.store ? "store user" : "update user").tr.toCapitalize();
    

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
                  initialValue: type == UserFormScreenType.update
                    ? Get.arguments["data"].name
                    : "",
                  labelText: "user name".tr.toCapitalize(),
                  hintText: "user name".tr.toCapitalize(),
                ),
                const SizedBox(height: 10),
                PAMFormTextFieldWidget(
                  onSaved: (newValue) => email.value = newValue!,
                  initialValue: type == UserFormScreenType.update
                    ? Get.arguments["data"].email
                    : "",
                  labelText: "user email".tr.toCapitalize(),
                  hintText: "user email".tr.toCapitalize(),
                ),
                const SizedBox(height: 10),
                
                if (type == UserFormScreenType.store) PAMFormTextFieldWidget(
                  onSaved: (newValue) => password.value = newValue!,
                  initialValue: type == UserFormScreenType.update
                    ? Get.arguments["data"].password
                    : "",
                  labelText: "user password".tr.toCapitalize(),
                  hintText: "user password".tr.toCapitalize(),
                ),
                
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10
                  ),
                  child: PAMFormOptionsWidget(
                    onSaved: (newValue) => gender.value = newValue!,
                    context: context,
                    initialValue: type == UserFormScreenType.update
                      ? Get.arguments["data"].gender
                      : "",
                    label: "gender".tr.toCapitalize(),  
                    options: [
                      PAMFormOptionItemWidget(
                        label: "man".tr.toCapitalize(), 
                        value: "pria"
                      ),
                      PAMFormOptionItemWidget(
                        label: "woman".tr.toCapitalize(), 
                        value: "wanita"
                      )
                    ]
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10
                  ),
                  child: PAMFormOptionsWidget(
                    context: context,
                    label: "role".tr.toCapitalize(), 
                    onSaved: (newValue) => role.value = newValue!,
                    initialValue: type == UserFormScreenType.update
                      ? Get.arguments["data"].role
                      : "",
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
                  ),
                ),
                const SizedBox(height: 50),
                PAMBottom(
                  title: typeFormTitle,
                  isLoading: false,
                  borderRadius: BorderRadius.circular(10),
                  onTab: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      
                      final UserPaylaod paylaod = UserPaylaod(
                        id: Get.arguments["data"].id,
                        name: name.value, 
                        gender: gender.value, 
                        email: email.value, 
                        password: password.value, 
                        role: role.value
                      );

                      // handling action 
                      if (type == UserFormScreenType.store) controller.userStore(paylaod);
                      if (type == UserFormScreenType.update) controller.userUpdate(paylaod);
                
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
