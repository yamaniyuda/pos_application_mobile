import 'package:flutter/material.dart';
import 'package:pos_application_mobile/app/extensions/string_extention.dart';

class PAMFormTextFieldWidget extends StatefulWidget {
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final String? hintText;
  final int? maxLines;
  final Widget? suffixIcon;
  final Widget? icon;
  final String? labelText;
  final EdgeInsetsGeometry? padding;
  final String? initialValue;
  final ValueChanged<String>? onChanged;
  final BoxDecoration? decoration;
  final void Function(String?)? onSaved;

  const PAMFormTextFieldWidget({
    super.key,
    this.keyboardType,
    this.initialValue,
    this.labelText,
    this.maxLines,
    this.suffixIcon,
    this.hintText,
    this.padding,
    this.onChanged,
    this.decoration,
    this.icon,
    this.validator,
    this.onSaved
  });

  @override
  State<PAMFormTextFieldWidget> createState() => _PAMFormTextFieldWidgetState();
}

class _PAMFormTextFieldWidgetState extends State<PAMFormTextFieldWidget> {
  final _textFieldKey = GlobalKey();
  double _textFieldHeight = 0;


  /*
    This is variable use when nothing custom
    style from this widgets
   */
  final BoxDecoration _textShadowStyle = BoxDecoration(
    color: Colors.white,
    boxShadow: const [
      BoxShadow(
        blurRadius: 10,
        spreadRadius: -9,
        offset: Offset(0, 2)
      )
    ],
    borderRadius: BorderRadius.circular(10)
  );


  /*
    Default styling form field
    when you want to overwrite this style you
    must call copy with for assign new styling
   */
  late final InputDecoration _inputFormStyle = InputDecoration(
    icon: widget.icon,
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
    )
  );


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
          decoration: widget.decoration ?? _textShadowStyle
        ),
        TextFormField(
          key: _textFieldKey,
          onSaved: widget.onSaved,
          onChanged: widget.onChanged,
          initialValue: widget.initialValue,
          keyboardType: widget.keyboardType,
          validator: widget.validator,
          maxLines: widget.maxLines,
          textAlignVertical: TextAlignVertical.center,
          decoration: _inputFormStyle
        ),
      ]
    );
  }
}
