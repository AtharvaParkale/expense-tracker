import 'dart:ui';

import 'package:expense_tracker_app/core/constants/image_path.dart';
import 'package:expense_tracker_app/features/errors/presentation/strategy/error_strategy_interface.dart';

class DefaultErrorStrategy implements ErrorStrategy {
  @override
  VoidCallback callback() {
    return () {
      print('Retry');
    };
  }

  @override
  String getErrorImage() {
    return ImagePath.defaultErrorImage;
  }

  @override
  String getSubTitle() {
    return "Looks like something went off-script. We’re not sure what broke, but it definitely wasn’t part of the plan. Try again in a bit — or pretend it never happened. ";
  }

  @override
  String getTitle() {
    return "Oops! That Wasn’t Supposed to Happen…";
  }
}
