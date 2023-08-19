import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class PAMFormOptionItemWidget {
  final String label;
  final String value;

  PAMFormOptionItemWidget({
    required this.label,
    required this.value 
  });
}

class PAMFormOptionsWidget extends FormField<String> {
  PAMFormOptionsWidget({
    super.key,
    FormFieldSetter<String>? onSaved,
    required BuildContext context,
    required String label,
    required List<PAMFormOptionItemWidget> options, 
    FormFieldValidator<String>? validator,
    String? initialValue
  }) : super(
    onSaved: onSaved,
    validator: validator,
    initialValue: initialValue,
    builder: (FormFieldState<String> state) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          const SizedBox(height: 10),
          Wrap(
            runSpacing: 12,
            spacing: 12,
            alignment: WrapAlignment.start,
            children: options.map((e) {
              return InkWell(
                onTap: () {
                  state.didChange(e.value);
                },
                splashColor: Colors.transparent, // Set the splash color to transparent
                highlightColor: Colors.transparent,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 8
                  ),
                  decoration: BoxDecoration(
                    color: e.value == state.value
                      ? Theme.of(context).primaryColor.withOpacity(0.1)
                      : Colors.white,
                    border: Border.all(

                      color: e.value == state.value
                        ? Theme.of(context).primaryColor
                        : Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(40)
                  ),
                  child: Text(
                    e.label,
                    style: GoogleFonts.lato(
                      color: Colors.black54.withOpacity(0.5),
                      fontSize: 18
                    ),
                  ),
                ),
              );
            }).toList(),
          )
        ],
      );
    }
  );
}