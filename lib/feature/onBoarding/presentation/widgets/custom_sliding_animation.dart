import 'package:flutter/widgets.dart';

class CustomSlidingAnimation extends StatelessWidget {
  const CustomSlidingAnimation({super.key, required this.child});

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.3, 0.0),
                end: const Offset(0.0, 0.0),
              ).animate(animation),
              child: child,
            ),
          );
        },
        child: child);
  }
}
