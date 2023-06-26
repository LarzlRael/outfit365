part of 'animations.dart';

class BounceUp extends StatefulWidget {
  final Widget child;

  const BounceUp({super.key, required this.child});
  @override
  State<BounceUp> createState() => _BounceUpState();
}

class _BounceUpState extends State<BounceUp>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )
      ..forward()
      ..repeat(reverse: true);

    _animation = Tween<double>(begin: 0, end: 30).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.bounceIn,
      ),
    );
    /* _controller.addListener(() {
      if (_controller.isCompleted) {
        _controller.reverse();
      }
    }); */
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      child: widget.child,
      builder: (_, Widget? child) {
        return Transform.translate(
          offset: Offset(0, -_animation.value),
          child: widget.child,
        );
      },
    );
  }
}
