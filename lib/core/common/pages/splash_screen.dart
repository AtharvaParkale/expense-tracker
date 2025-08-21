import 'package:expense_tracker_app/core/constants/constants.dart';
import 'package:expense_tracker_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppPallete.whiteColor,
      body: Padding(
        padding: EdgeInsets.all(44.0),
        child: Center(child: Image(image: AssetImage(Constants.appLogo))),
      ),
    );
  }
}
