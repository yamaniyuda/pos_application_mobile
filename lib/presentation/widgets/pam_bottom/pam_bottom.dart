import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pos_application_mobile/app/extensions/string_extention.dart';

enum PAMBottomType {
  general, outline
}

class PAMBottom extends StatelessWidget {
  final String title;
  final void Function()? onTab;
  final bool isLoading;
  final BorderRadiusGeometry? borderRadius;
  final PAMBottomType type;

  const PAMBottom({
    super.key,
    required this.title,
    this.onTab,
    this.isLoading = false,
    this.type = PAMBottomType.general,
    this.borderRadius
  });

  Widget _buildGeneralButton(BuildContext context) {
    return GestureDetector(
      onTap: onTab,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: borderRadius ?? BorderRadius.circular(100)
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

  Widget _buildOutlineButton(BuildContext context) {
    return OutlinedButton(
      onPressed: onTab,
      style: OutlinedButton.styleFrom(
        foregroundColor: Theme.of(context).primaryColor, minimumSize: const Size.fromHeight(50),
        side: BorderSide(
          width: 1,
          color: Theme.of(context).primaryColor
        )
      ),
      child: Text(
        title.toCapitalize(),
        style: GoogleFonts.lato(
          color: Theme.of(context).primaryColor
        )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (type == PAMBottomType.general) {
      return _buildGeneralButton(context);
    } else {
      return _buildOutlineButton(context);
    }
  }
}
