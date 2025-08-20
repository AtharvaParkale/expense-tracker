import 'package:expense_tracker_app/core/constants/app_dimensions.dart';
import 'package:expense_tracker_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

void openBottomSheet(BuildContext context, Widget content) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(AppDimensions.defaultPadding),
            decoration: const BoxDecoration(
              color: AppPallete.whiteColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(30.0),
                topLeft: Radius.circular(30.0),
              ),
            ),
            child: content,
          ),
        ),
      );
    },
  );
}
