// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pos_application_mobile/app/extensions/string_extention.dart';
import 'package:pos_application_mobile/data/payloads/sign_in_payload.dart';
import 'package:pos_application_mobile/presentation/app/auth/controllers/auth_controller.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_bottom/pam_bottom.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_form/pam_form.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_logo/pam_logo.dart';

class AuthScreen extends GetView<AuthController> {
  final _formKey = GlobalKey<FormState>();

  /* form state */
  RxString username = "".obs;
  RxString password = "".obs;
  RxBool showPassword = false.obs;

  RxBool isLoading = false.obs;

  AuthScreen({super.key});

  Widget _buildUsernameForm() {
    return PAMFormTextFieldWidget(
      key: const Key("sign_in_form_username"),
      hintText: "enter here".tr,
      labelText: "username",
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return "username ${"required".tr}";
        }
        return null;
      },
      onSaved: (String? value) {
        username.value = value!;
      },
    );
  }

  Widget _buildPasswordForm() {
    return PAMFormTextFieldWidget(
      key: const Key("sign_in_form_password"),
      hintText: "enter here".tr,
      labelText: "password",
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return "password ${"required".tr}";
        }
        return null;
      },
      type: PAMFormTextFieldWidgetType.password,
      onSaved: (String? value) {
        password.value = value!;
      },
    );
  }

  Widget _optionalAction(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: Get.width * 0.4,
          child: PAMFormCheckboxWidget(
              onSaved: (value) {
                if (value!.isNotEmpty && value[0] == "remember me".tr) {
                  controller.rememberMe.value = true;
                }
              },
              options: [
                "remember me".tr,
              ]
          ),
        ),
        GestureDetector(
          child: Text(
            "forgot password".tr.toCapitalize(),
            textAlign: TextAlign.right,
            style: GoogleFonts.lato(
              color: Theme
                  .of(context)
                  .primaryColor,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildBottomSubmit(BuildContext context) {
    return Obx(() {
      return PAMBottom(
        key: const Key("sign_in_form_submit"),
        title: "login".tr,
        isLoading: isLoading.value,
        onTab: () async {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();

            await controller.signIn(
              SignInPayload(
                username: username.value,
                password: password.value
              )
            );

            isLoading.value = true;

            await Future.delayed(const Duration(seconds: 2));
            isLoading.value = false;
          }
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF7F7F7),
        body: SafeArea(
          child: ListView(
            shrinkWrap: true,
            children: [
              const SizedBox(height: 20),
              const PAMLogo(),
              const SizedBox(height: 36),
              Text(
                "${"welcome you".tr}!".toCapitalize(),
                textAlign: TextAlign.center,
                style: GoogleFonts.lato(
                    fontSize: 22
                ),
              ),
              const SizedBox(height: 26),
              TabBar(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  controller: controller.tabController,
                  labelColor: Theme
                    .of(context)
                    .primaryColor,
                  indicatorColor: Theme
                    .of(context)
                    .primaryColor,
                  tabs: [
                    Tab(
                      child: Text(
                        "login".tr  ,
                        style: GoogleFonts.lato(
                          fontSize: 16,
                          color: Theme
                            .of(context)
                            .primaryColor
                        ),
                      ),
                    )
                  ]
              ),
              const SizedBox(height: 20),
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  height: Get.height * 0.5,
                  child: TabBarView(
                    controller: controller.tabController,
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            /* begin: form build */
                            _buildUsernameForm(),
                            const SizedBox(height: 14),
                            _buildPasswordForm(),
                            const SizedBox(height: 14),
                            _optionalAction(context),
                            const SizedBox(height: 30),
                            _buildBottomSubmit(context)
                            /* end: form build */

                          ],
                        ),
                      )
                    ]
                  )
              ),
            ],
          ),
        )
    );
  }
}