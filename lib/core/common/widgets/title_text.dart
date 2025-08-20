import 'package:expense_tracker_app/core/constants/app_dimensions.dart';
import 'package:expense_tracker_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  const TitleText({
    super.key,
    required this.text,
    required this.textAlign,
  });

  final String text;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: AppDimensions.title,
        fontWeight: FontWeight.w700,
        fontFamily: 'Poppins',
        color: AppPallete.primaryColor,
      ),
      textAlign: textAlign,
    );
  }
}
