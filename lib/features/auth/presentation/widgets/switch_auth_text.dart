import 'package:expense_tracker_app/core/constants/app_dimensions.dart';
import 'package:expense_tracker_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class SwitchAuthText extends StatelessWidget {
  const SwitchAuthText({
    super.key,
    required this.prefixText,
    required this.postFixText,
    required this.onPress,
  });

  final String prefixText;
  final String postFixText;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: RichText(
        text: TextSpan(
          text: prefixText,
          style: TextStyle(
            fontSize: AppDimensions.smallText,
            fontWeight: FontWeight.w500,
            fontFamily: 'Poppins',
            color: AppPallete.bgBlack,
          ),
          children: [
            TextSpan(
              text: postFixText,
              style: TextStyle(
                fontSize: AppDimensions.smallText,
                fontWeight: FontWeight.w700,
                fontFamily: 'Poppins',
                color: AppPallete.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
