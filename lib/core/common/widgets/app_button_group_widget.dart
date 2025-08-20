import 'package:expense_tracker_app/core/common/widgets/app_button_widget.dart';
import 'package:expense_tracker_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AppButtonGroupWidget extends StatefulWidget {
  const AppButtonGroupWidget({
    super.key,
    required this.buttonOneText,
    required this.buttonTwoText,
    required this.handleButtonOneTap,
    required this.handleButtonTwoTap,
    this.isButtonOneDisable = false,
    this.isButtonTwoDisabled = false,
    this.isButtonOneLoading = false,
    this.isButtonTwoLoading = false,
  });

  final String buttonOneText;
  final String buttonTwoText;
  final Function() handleButtonOneTap;
  final Function() handleButtonTwoTap;
  final bool isButtonOneDisable;
  final bool isButtonTwoDisabled;
  final bool isButtonOneLoading;
  final bool isButtonTwoLoading;

  @override
  State<AppButtonGroupWidget> createState() => _AppButtonGroupWidgetState();
}

class _AppButtonGroupWidgetState extends State<AppButtonGroupWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: AppButtonWidget(
            text: widget.buttonOneText,
            bgColor: AppPallete.whiteColor,
            fontColor: AppPallete.primaryColor,
            fontWeight: FontWeight.w600,
            onPressed: widget.handleButtonOneTap,
            isLoading: widget.isButtonOneLoading,
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: AppButtonWidget(
            text: widget.buttonTwoText,
            bgColor: AppPallete.primaryColor,
            fontColor: AppPallete.whiteColor,
            fontWeight: FontWeight.w600,
            onPressed: widget.handleButtonTwoTap,
            isLoading: widget.isButtonTwoLoading,
          ),
        ),
      ],
    );
  }
}
