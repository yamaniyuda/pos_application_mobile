import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_application_mobile/app/extensions/string_extention.dart';

enum PAMFormTextFieldWidgetType { text, password }

class PAMFormTextFieldWidget extends StatefulWidget {
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final String? hintText;
  final int? maxLines;
  final Widget? suffixIcon;
  final Widget? icon;
  final String? hiddenValue;
  final String? labelText;
  final bool obscureText;
  final Widget? screen;
  final EdgeInsetsGeometry? padding;
  final String? initialValue;
  final ValueChanged<String>? onChanged;
  final PAMFormTextFieldWidgetType type;
  final InputDecoration? inputDecoration;
  final BoxDecoration? decoration;
  final void Function(String?)? onSaved;
  final void Function()? onTabSuffixIcon;

  const PAMFormTextFieldWidget({
    super.key,
    this.obscureText = false,
    this.keyboardType,
    this.initialValue,
    this.labelText,
    this.hiddenValue,
    this.maxLines,
    this.suffixIcon,
    this.screen,
    this.hintText,
    this.type = PAMFormTextFieldWidgetType.text,
    this.padding,
    this.onChanged,
    this.decoration,
    this.inputDecoration,
    this.onTabSuffixIcon,
    this.icon,
    this.validator,
    this.onSaved
  });

  @override
  State<PAMFormTextFieldWidget> createState() => _PAMFormTextFieldWidgetState();
}

class _PAMFormTextFieldWidgetState extends State<PAMFormTextFieldWidget> {
  final _textFieldKey = GlobalKey();
  final TextEditingController _controller = TextEditingController();
  String _hiddenValue = "";
  double _textFieldHeight = 0;
  bool _showPassword = false;

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
    _controller.text = widget.initialValue ?? "";

    /// State optional screen form
    /// if widget screen exist hidden value  set to inital value
    setState(() {
      _hiddenValue = widget.hiddenValue ?? "";
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
          controller: _controller,
          onSaved: widget.screen == null ? widget.onSaved : (String? string) {
            widget.onSaved!(_hiddenValue);
          },
          onChanged: widget.onChanged,
          keyboardType: widget.keyboardType,
          validator: widget.validator,
          textAlignVertical: TextAlignVertical.center,
          readOnly: widget.screen != null ? true : false,
          maxLines: widget.type == PAMFormTextFieldWidgetType.password ? 1 : widget.maxLines,
          obscureText: widget.type == PAMFormTextFieldWidgetType.password && !_showPassword 
            ? true : false,
          onTap: onTapHandler,
          decoration: widget.inputDecoration ?? _inputFormStyle.copyWith(
            suffixIcon: widget.type == PAMFormTextFieldWidgetType.password 
              ? IconButton(
                  hoverColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onPressed: () => setState(() {
                    _showPassword = !_showPassword;
                  }),
                  icon: Icon(_showPassword ? Icons.visibility : Icons.visibility_off),
                )
              : null,
          )
        ),
      ]
    );
  }

  /// on tap hanler function
  /// 
  /// The `onTapHanler` function for handling text with option value
  /// and options value redirect to screen options get from params
  /// this screen will throw value by arguments.
  void onTapHandler() async {
    if (widget.screen != null) {
      final result = await Get.to(widget.screen, arguments: {
        "value": _controller.text
      });

      if (result is Map) {
        _controller.text = result["label"]!;

        setState(() {
          _hiddenValue = result["value"]!;

          if (widget.onChanged != null) {
            widget.onChanged!(result["value"]!);
          }
        });
      }
    }
  }
}
