import 'package:flutter/material.dart';
import 'package:pos_application_mobile/app/extensions/string_extention.dart';

class PAMBottom extends StatelessWidget {
  final String title;
  final void Function()? onTab;
  const PAMBottom({super.key, required this.title, this.onTab});

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
        child: Text(
          title.toCapitalize(),
          textAlign: TextAlign.center,
          style: const TextStyle( 
            color: Colors.white,
            height: 2.4,
            fontSize: 16,
            fontFamily: 'Lato',
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
