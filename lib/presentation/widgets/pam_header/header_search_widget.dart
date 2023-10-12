import 'package:flutter/material.dart';
import 'package:pos_application_mobile/app/extensions/string_extention.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_form/pam_form.dart';

class HeaderSearchWidget extends StatelessWidget {
  const HeaderSearchWidget({
    super.key,
    required this.onTabFilter,
    required this.placeholder,
    required this.onChange
  });


  final String placeholder;
  final void Function() onTabFilter;
  final Function(String? value) onChange;


  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white, 
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(bottom: 4, right: 10, left: 10),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(10)
              ),
              child: PAMFormTextFieldWidget(
                hintText: placeholder.toCapitalize(),
                decoration: const BoxDecoration(),
                onChanged: onChange,
              ),
            ),
          ),
          Container(
            width: 60,
            alignment: Alignment.center,
            color: Colors.white,
            child: GestureDetector(
              onTap: onTabFilter,
              child: const Icon(Icons.tune),
            ),
          )
        ],
      ),
    );
  }
}