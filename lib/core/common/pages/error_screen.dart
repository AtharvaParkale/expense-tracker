import 'package:expense_tracker_app/core/common/widgets/app_button_widget.dart';
import 'package:expense_tracker_app/core/constants/app_dimensions.dart';
import 'package:expense_tracker_app/core/constants/app_font_weigth.dart';
import 'package:expense_tracker_app/core/constants/error_codes.dart';
import 'package:expense_tracker_app/core/theme/app_pallete.dart';
import 'package:expense_tracker_app/core/theme/app_text_theme.dart';
import 'package:expense_tracker_app/features/errors/presentation/strategy/default_error_strategy.dart';
import 'package:expense_tracker_app/features/errors/presentation/strategy/error_stratergy_context.dart';
import 'package:expense_tracker_app/features/errors/presentation/strategy/internet_error_strategy.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ErrorScreen extends StatefulWidget {
  const ErrorScreen({super.key, required this.errorCode});

  final String errorCode;

  @override
  State<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  late ErrorHandler errorHandler;

  @override
  Widget build(BuildContext context) {
    errorHandler = _initiateErrorHandler();
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppDimensions.horizontalPadding,
          vertical: 40,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              _buildLottie(),
              const SizedBox(height: 10),
              _buildTitle(),
              const SizedBox(height: 20),
              _buildSubTitle(),
              const Spacer(),
              _buildRetryButton(context),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox _buildRetryButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: AppButtonWidget(
        text: 'Retry',
        bgColor: AppPallete.primaryColor,
        fontColor: AppPallete.whiteColor,
        fontWeight: FontWeight.w700,
        onPressed: () {},
      ),
    );
  }

  Widget _buildLottie() {
    return Lottie.asset(
      errorHandler.strategy.getErrorImage(),
      width: 280,
      height: 280,
    );
  }

  Text _buildTitle() {
    return Text(
      errorHandler.strategy.getTitle(),
      style: appTextTheme.titleMedium?.copyWith(
        fontWeight: AppFontWeight.bold,
        color: AppPallete.primaryColor,
      ),
      textAlign: TextAlign.center,
    );
  }

  Padding _buildSubTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Text(
        errorHandler.strategy.getSubTitle(),
        style: appTextTheme.bodyMedium?.copyWith(
          fontWeight: AppFontWeight.medium,
          color: AppPallete.descriptionColor,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  ErrorHandler _initiateErrorHandler() {
    if (widget.errorCode == ErrorCodes.noInternetConnectionErrorCode) {
      return ErrorHandler(InternetErrorStrategy());
    } else if (widget.errorCode == ErrorCodes.somethingWentWrongErrorCode) {
      return ErrorHandler(DefaultErrorStrategy());
    } else {
      return ErrorHandler(DefaultErrorStrategy());
    }
  }
}
