import 'dart:ui';

abstract interface class ErrorStrategy {
  String getTitle();

  String getSubTitle();

  String getErrorImage();

  VoidCallback callback();
}
