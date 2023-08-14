import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pos_application_mobile/app/extensions/string_extention.dart';

class PAMBottom extends StatelessWidget {
  final String title;
  final void Function()? onTab;
  final bool isLoading;
  const PAMBottom({super.key, required this.title, this.onTab, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTab,
      child: Container(
        width: 274,
        height: 50,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(100)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            isLoading
                ? LoadingAnimationWidget.waveDots(
                    color: Colors.white,
                      size: 50
                  )
                : Text(
                    title.toCapitalize(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
          ],
        )
      )
    );
  }
}
