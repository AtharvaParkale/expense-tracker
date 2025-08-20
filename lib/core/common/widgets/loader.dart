
import 'package:expense_tracker_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.primaryColor,
      appBar: AppBar(
        title: const Text(""),
        backgroundColor: AppPallete.primaryColor,
      ),
      body: Center(
        child: Lottie.asset(
          'assets/images/lottie/circular_loader.json',
          height: 200,
          width: 200,
        ),
      ),
    );
  }
}
