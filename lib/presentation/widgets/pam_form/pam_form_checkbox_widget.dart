import 'package:flutter/material.dart';
import 'package:pos_application_mobile/app/extensions/string_extention.dart';

class PAMFormCheckboxWidget extends FormField<List<String>> {
  PAMFormCheckboxWidget({
    super.key,
    required FormFieldSetter<List<String>> onSaved,
    FormFieldValidator<List<String>>? validator,
    required List<String> options,
    List<String>? initialValue,
  }): super(
    onSaved: onSaved,
    validator: validator,
    initialValue: initialValue ?? [],
    builder: (FormFieldState<List<String>> field) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: options.map((value) => CheckboxListTile(
          controlAffinity: ListTileControlAffinity.leading,
          contentPadding: const EdgeInsets.all(0),
          value: field.value!.contains(value),
          activeColor: Theme.of(field.context).primaryColor,
          title: Text(value.toCapitalize()),
          onChanged: (checked) {
            if (checked != null) {
              List<String> newValue = List.from(field.value!);
              if (checked) {
                newValue.add(value);
              } else {
                newValue.remove(value);
              }

              field.didChange(newValue);
            }
          }
        )).toList(),

        // children: options.map((value) => Row(
        //   mainAxisAlignment: MainAxisAlignment.start,
        //   mainAxisSize: MainAxisSize.min,
        //   children: [
        //     Checkbox(
        //       value: field.value!.contains(value),
        //       onChanged: (checked) {
        //         if (checked != null) {
        //           List<String> newValue = List.from(field.value!);
        //           if (checked) {
        //             newValue.add(value);
        //           } else {
        //             newValue.remove(value);
        //           }
        //
        //           field.didChange(newValue);
        //         }
        //       }
        //     ),
        //     Text(value.toCapitalize())
        //   ],
        // )).toList(),
      );
    }
  );
}