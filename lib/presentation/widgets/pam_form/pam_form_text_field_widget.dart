import 'package:flutter/material.dart';
import 'package:pos_application_mobile/app/extensions/string_extention.dart';

class PAMFormTextFieldWidget extends StatefulWidget {
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final String? hintText;
  final int? maxLines;
  final Widget? suffixIcon;
  final String? labelText;
  final void Function(String?)? onSaved;

  const PAMFormTextFieldWidget({
    super.key,
    this.keyboardType,
    this.labelText,
    this.maxLines,
    this.suffixIcon,
    this.hintText,
    this.validator,
    this.onSaved
  });

  @override
  State<PAMFormTextFieldWidget> createState() => _PAMFormTextFieldWidgetState();
}

class _PAMFormTextFieldWidgetState extends State<PAMFormTextFieldWidget> {
  final _textFieldKey = GlobalKey();
  double _textFieldHeight = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final RenderBox renderBox = _textFieldKey.currentContext?.findRenderObject() as RenderBox;
      setState(() {
        _textFieldHeight = renderBox.size.height;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: _textFieldHeight,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                blurRadius: 10,
                spreadRadius: -9,
                offset: Offset(
                  0, 2
                )
              )
            ],
            borderRadius: BorderRadius.circular(10)
          ),
        ),
        TextFormField(
          key: _textFieldKey,
          onSaved: widget.onSaved,
          keyboardType: widget.keyboardType,
          validator: widget.validator,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            labelText: widget.labelText?.toCapitalize(),
            labelStyle: TextStyle(
              color: Theme.of(context).primaryColorDark.withOpacity(0.5),
              wordSpacing: 1,
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon: widget.suffixIcon,
            hintText: widget.hintText?.toCapitalize(),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12
            ),
          ),
        ),
      ]
    );
  }
}
