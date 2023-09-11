import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pos_application_mobile/app/extensions/string_extention.dart';
import 'package:pos_application_mobile/app/utils/system_utils.dart';

/// PAMBottomSheet Widget
///
/// The `PAMBottomSheet` widget is designed to provide an easy way to display a
/// bottom sheet when a button is pressed. It simplifies the process of creating
/// a button that triggers a bottom sheet in your Flutter app.
///
/// Example:
/// ```dart
/// PAMBottomSheet(
///   buttom: Icon(Icons.add), // The button widget that triggers the bottom sheet.
///   bottomSheet: YourCustomBottomSheetWidget(), // The content of the bottom sheet.
///   title: 'Add Item', // Title displayed in the bottom sheet.
/// )
/// ```
class PAMBottomSheet extends StatelessWidget {
  /// Constructor for PAMBottomSheet widget.
  ///
  /// The [buttom] parameter is the widget that will be used as the button
  /// to trigger the bottom sheet.
  ///
  /// The [bottomSheet] parameter is the content of the bottom sheet that
  /// will be displayed when the button is pressed.
  ///
  /// The [title] parameter is the title displayed in the bottom sheet.
  const PAMBottomSheet({
    Key? key,
    required this.buttom,
    required this.bottomSheet,
    required this.title,
  }) : super(key: key);

  /// The widget that serves as the button to trigger the bottom sheet.
  final Widget buttom;

  /// The content of the bottom sheet that will be displayed.
  final Widget bottomSheet;

  /// The title displayed in the bottom sheet.
  final String title;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        SystemUtils.changeStatusAndBottomBarColor(
          context,
          statusBarColor: Colors.white.withOpacity(.004),
          statusBarIconBrightness:  Brightness.light
        );

        Get.bottomSheet(
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title.toCapitalize(),
                  style: GoogleFonts.lato(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  ),
                ),                                                // Displayed title in the bottom sheet.
                bottomSheet,                                      // Display the custom content of the bottom sheet.
              ],
            ),
          ),
        )
        .then((value) {
          SystemUtils.changeStatusAndBottomBarColor(context);
        });
      },
      icon: buttom,
    );
  }
}
