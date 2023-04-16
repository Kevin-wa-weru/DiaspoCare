import 'package:flutter/material.dart';

class LoadingContainerAnimation extends StatefulWidget {
  const LoadingContainerAnimation({super.key, required this.targetContainer});
  final Widget targetContainer;
  @override
  State<LoadingContainerAnimation> createState() =>
      _LoadingContainerAnimationState();
}

/// [AnimationController]s can be created with `vsync: this` because of
/// [TickerProviderStateMixin].
class _LoadingContainerAnimationState extends State<LoadingContainerAnimation>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat();
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.bounceInOut,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
        sizeFactor: _animation,
        axis: Axis.horizontal,
        axisAlignment: -1,
        child: widget.targetContainer);
  }
}
