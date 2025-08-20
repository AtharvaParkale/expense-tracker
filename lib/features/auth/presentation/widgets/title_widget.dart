import 'package:expense_tracker_app/core/constants/app_dimensions.dart';
import 'package:expense_tracker_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    super.key,
    required this.textOne,
    required this.textTwo,
  });

  final String textOne;
  final String textTwo;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: textOne,
        style: TextStyle(
          fontSize: AppDimensions.title,
          fontWeight: FontWeight.w700,
          fontFamily: 'Poppins',
          color: AppPallete.whiteColor,
        ),
        children: <TextSpan>[
          TextSpan(
            text: textTwo,
            style: TextStyle(
              fontSize: AppDimensions.title,
              fontWeight: FontWeight.w700,
              fontFamily: 'Poppins',
              color: AppPallete.secondaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
