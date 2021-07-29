import 'package:flutter/material.dart';

class PageTransition {
  PageTransition._();

  static PageRouteBuilder slide(Widget page) =>
      _baseSlide(page, const Offset(0.0, 1.0), Offset.zero, Curves.ease);

  static PageRouteBuilder slideRight(Widget page) =>
      _baseSlide(page, const Offset(-1, 0), Offset.zero);

  static PageRouteBuilder slideUpRoute(Widget page) =>
      _baseSlide(page, const Offset(0, 1), Offset.zero);

  static PageRouteBuilder slideDownRoute(Widget page) =>
      _baseSlide(page, const Offset(0, -1.0), Offset.zero);

  static PageRouteBuilder slideBottomRight(Widget page) =>
      _baseSlide(page, const Offset(1, 1), Offset.zero);

  static PageRouteBuilder slideLeft(Widget page) =>
      _baseSlide(page, const Offset(1, 0), const Offset(0, 0));

  static PageRouteBuilder _baseSlide(
      Widget page, Offset begin, Offset end, [Curve? curve]
      )
  {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final tween = curve == null
            ? Tween(begin: begin, end: end)
            : Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
