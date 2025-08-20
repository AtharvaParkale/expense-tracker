import 'dart:ui';
import 'package:expense_tracker_app/core/constants/image_path.dart';
import 'package:expense_tracker_app/features/errors/presentation/strategy/error_strategy_interface.dart';

class InternetErrorStrategy implements ErrorStrategy {
  @override
  VoidCallback callback() {
    return () {
      print('Retry');
    };
  }

  @override
  String getErrorImage() {
    return ImagePath.noInternetError;
  }

  @override
  String getSubTitle() {
    return "We couldn’t connect to the internet. Something’s blocking the signal — check your connection and try again. We’ll be here when you’re back online.";
  }

  @override
  String getTitle() {
    return "No Internet Connection";
  }
}
