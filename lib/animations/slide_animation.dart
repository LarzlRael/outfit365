part of 'animations.dart';

class SlideAnimation extends StatefulWidget {
  final Widget child;

  const SlideAnimation({super.key, required this.child});
  @override
  State<SlideAnimation> createState() => _SlideAnimationState();
}

class _SlideAnimationState extends State<SlideAnimation>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  late Animation<double> scaleAnimation;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1001));
    _animation =
        Tween<double>(begin: -400, end: 0).animate(_animationController);
    scaleAnimation =
        Tween<double>(begin: .2, end: 1).animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    _animationController.forward();
    return AnimatedBuilder(
      animation: _animationController,
      child: widget.child,
      builder: (context, child) => Transform.scale(
          scale: scaleAnimation.value, child: child
          /* child: Transform.translate(
          offset: Offset(_animation.value, 0),
          child: child,
        ), */
          ),
    );
  }
}
