import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:pos_application_mobile/app/extensions/string_extention.dart';
import 'package:pos_application_mobile/domain/use_cases/auth/sign_in_use_case.dart';
import 'package:pos_application_mobile/presentation/app/auth/controllers/auth_controller.dart';
import 'package:pos_application_mobile/presentation/app/auth/auth.dart';


void main() {
  // Mock the GetX controller for testing
  // Create a fake instance of AuthController and register it with Get

  // setUpAll(() async {
  //   await loadTestEnv();
  // });

  testWidgets('AuthScreen username, password, and submit test', (WidgetTester tester) async {
    // Build the AuthScreen widget
    await tester.pumpWidget(GetMaterialApp(
      home: AuthScreen(),
      initialBinding: BindingsBuilder(() {
        Get.lazyPut(() => SignInUseCase());
        Get.put<AuthController>(AuthController());
      }),
    ));

    // Find the text fields for username and password
    final usernameTextField = find.byKey(const Key("sign_in_form_username"));
    final passwordTextField = find.byKey(const Key("sign_in_form_password"));

    // Enter text into the username and password text fields
    await tester.enterText(usernameTextField, 'admin@alshaftour.com');
    await tester.enterText(passwordTextField, 'password');

    // Verify that the entered text is correct
    expect(find.text('admin@alshaftour.com'), findsOneWidget);
    expect(find.text('password'), findsOneWidget);

    // Tap on the "login" button
    final loginButton = find.byKey(const Key("sign_in_form_submit"));
    await tester.tap(loginButton);
    await tester.pump();

    // Verify that the loading dialog is shown after tapping the login button
    // expect(find.text('data diproses'.tr.toCapitalize()), findsOneWidget);

    // In your real app, you would need to mock the controller's response for signIn,
    // and then verify the behavior based on that response.
    // Since we are not testing the actual server call, we will just check if Get.back()
    // is called after the controller's signIn function is called.

    // For example, you can do something like this in your AuthController:
    // final controller = Get.find<AuthController>();
    // controller.signIn(SignInPayload(username: 'test_username', password: 'test_password'));
    // await tester.pump();
    // expect(Get.currentRoute, Routes.home); // Check if the route changed to home after successful login
    // Get.back(); // Since we don't have a real server call, we manually call Get.back() here

    // In the real app, you should verify the UI changes based on the response from the controller,
    // like showing an error message if login fails or navigating to another screen if login is successful.
    // This example only shows how to test the UI behavior based on the user's actions.

  });
}
