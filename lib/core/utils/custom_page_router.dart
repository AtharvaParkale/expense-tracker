import 'package:flutter/material.dart';

class CustomPageRoute {
  static Route route(
    Widget child,
    PageRouteDirection direction,
  ) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        Offset begin = _getOffsetValue(direction);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(position: animation.drive(tween), child: child);
      },
    );
  }

  static Offset _getOffsetValue(PageRouteDirection direction) {
    switch (direction) {
      case PageRouteDirection.RIGHT:
        return const Offset(-1.0, 0.0);
      case PageRouteDirection.LEFT:
        return const Offset(1.0, 0.0);
      case PageRouteDirection.TOP:
        return const Offset(0.0, -1.0);
      case PageRouteDirection.BOTTOM:
        return const Offset(0.0, 1.0);
      default:
        return const Offset(1.0, 0.0);
    }
  }
}

enum PageRouteDirection {
  RIGHT,
  LEFT,
  TOP,
  BOTTOM,
}
