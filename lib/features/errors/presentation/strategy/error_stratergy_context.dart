import 'dart:ui';

import 'package:expense_tracker_app/features/errors/presentation/strategy/error_strategy_interface.dart';

class ErrorHandler {
  late ErrorStrategy strategy;

  ErrorHandler(this.strategy);

  void setStrategy(ErrorStrategy strategy) {
    this.strategy = strategy;
  }

  String getErrorTitle() {
    return strategy.getTitle();
  }

  String getErrorSubTitle() {
    return strategy.getSubTitle();
  }

  String getErrorImage() {
    return strategy.getErrorImage();
  }

  VoidCallback callback() {
    return strategy.callback();
  }
}
