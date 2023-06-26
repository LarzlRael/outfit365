part of 'animations.dart';

class FallInAnimation extends StatefulWidget {
  final Widget child;
  const FallInAnimation({
    super.key,
    required this.child,
  });

  @override
  State<FallInAnimation> createState() => _FallInAnimationState();
}

class _FallInAnimationState extends State<FallInAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    )..forward();
    _animation = Tween<double>(begin: -400, end: 0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutCubic,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: widget.child,
      builder: (context, child) => Transform.translate(
        offset: Offset(0, _animation.value),
        child: child,
      ),
    );
  }
}
