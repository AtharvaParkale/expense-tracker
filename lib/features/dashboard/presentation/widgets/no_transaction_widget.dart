import 'package:expense_tracker_app/core/constants/app_font_weigth.dart';
import 'package:expense_tracker_app/core/constants/image_path.dart';
import 'package:expense_tracker_app/core/theme/app_pallete.dart';
import 'package:expense_tracker_app/core/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart' show Lottie;

class NoTransactionWidget extends StatelessWidget {
  const NoTransactionWidget({super.key});

  @override
  Widget build(BuildContext context) {
     return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 200,
            child: Lottie.asset(
              ImagePath.defaultErrorImage,
              repeat: true,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "No transactions added today",
            textAlign: TextAlign.center,
            style: appTextTheme.bodyMedium?.copyWith(
              color: AppPallete.greyColor,
              fontWeight: AppFontWeight.semiBold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
