import 'package:expense_tracker_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AppButtonWidget extends StatelessWidget {
  const AppButtonWidget({
    super.key,
    this.padding = 16,
    this.fontSize = 15,
    this.borderRadius = 10,
    this.isLoading = false,
    required this.text,
    required this.bgColor,
    required this.fontColor,
    required this.fontWeight,
    required this.onPressed,
  });

  final double padding;
  final double fontSize;
  final double borderRadius;
  final String text;
  final Color bgColor;
  final Color fontColor;
  final FontWeight fontWeight;
  final VoidCallback onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: padding),
        backgroundColor: bgColor,
        textStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontFamily: 'Poppins',
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(borderRadius),
          ),
          side: const BorderSide(color: AppPallete.primaryColor),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        isLoading ? "Loading..." : text,
        style: TextStyle(
          color: fontColor,
        ),
      ),
    );
  }
}
