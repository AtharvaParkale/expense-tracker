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
          width: 5,
          height: 22,
          decoration: BoxDecoration(
            color: AppPallete.primaryColor,
            borderRadius: BorderRadius.circular(
              3,
            ),
          ),
        ),
        const SizedBox(width: 8),
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
