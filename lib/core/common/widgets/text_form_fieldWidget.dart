import 'package:expense_tracker_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatefulWidget {
  const TextFormFieldWidget({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    this.cursorColor = AppPallete.bgBlack,
    this.borderColor = AppPallete.bgBlack,
    this.fontColor = AppPallete.bgBlack,
    this.labelColor = AppPallete.bgBlack,
    this.focusedBorderColor = AppPallete.primaryColor,
    this.textInputType = TextInputType.text,
    this.obscureText = false,
    this.validator,
  });

  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final Color cursorColor;
  final Color borderColor;
  final Color fontColor;
  final Color labelColor;
  final Color focusedBorderColor;
  final TextInputType textInputType;
  final bool obscureText;
  final String? Function(String?)? validator;

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.obscureText,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        fontFamily: 'Poppins',
        color: widget.fontColor,
      ),
      cursorColor: widget.cursorColor,
      decoration: InputDecoration(
        labelText: widget.labelText,
        contentPadding: const EdgeInsets.all(20.0),
        labelStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          fontFamily: 'Poppins',
          color: widget.labelColor,
        ),
        hintText: widget.hintText,
        border: const OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: widget.borderColor, width: 2),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: widget.focusedBorderColor, width: 2),
        ),
      ),
      validator: widget.validator,
      keyboardType: widget.textInputType,
    );
  }
}
