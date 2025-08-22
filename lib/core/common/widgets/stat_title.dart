import 'package:expense_tracker_app/core/constants/app_font_weigth.dart';
import 'package:expense_tracker_app/core/theme/app_pallete.dart';
import 'package:expense_tracker_app/core/theme/app_text_theme.dart';
import 'package:flutter/material.dart';

class StatTitle extends StatelessWidget {
  const StatTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 5, // thickness of the line
          height: 22, // height of the line
          decoration: BoxDecoration(
            color: AppPallete.primaryColor,
            borderRadius: BorderRadius.circular(
              3,
            ), // half of width for full round edges
          ),
        ),
        const SizedBox(width: 8), // spacing between line and text
        Text(
          title,
          style: appTextTheme.bodyLarge?.copyWith(
            color: AppPallete.bgBlack,
            fontWeight: AppFontWeight.semiBold,
          ),
        ),
      ],
    );
  }
}
