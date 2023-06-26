part of '../pages.dart';

class AnimatedSquare extends StatefulWidget {
  static const String routeName = 'animation_square';
  const AnimatedSquare({super.key});

  @override
  State<AnimatedSquare> createState() => _AnimatedSquareState();
}

class _AnimatedSquareState extends State<AnimatedSquare>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> rotation;
  late Animation<double> opacity;
  late Animation<double> moveToRight;
  late Animation<double> scale;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );
    rotation = Tween<double>(begin: 0, end: 4 * pi).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeOut,
      ),
    );
    moveToRight = Tween<double>(begin: 0, end: 200).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeOut,
      ),
    );
    opacity = Tween<double>(begin: 0.1, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeOut,
      ),
    );
    scale = Tween<double>(begin: 0.1, end: 2).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeOut,
      ),
    );

    controller.addListener(() {
      if (controller.status == AnimationStatus.completed) {
        controller.reset();
      }
    });
  }

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.forward();
    return AnimatedBuilder(
      animation: controller,
      child: Center(
        child: Container(
          width: 100,
          height: 100,
          color: Colors.green,
        ),
      ),
      builder: (BuildContext context, Widget? child) {
        return Transform.scale(
          scale: scale.value,
          child: Transform.translate(
            offset: Offset(moveToRight.value, 0),
            child: Transform.rotate(
              angle: rotation.value,
              child: Opacity(
                opacity: opacity.value,
                child: child,
              ),
            ),
          ),
        );
      },
    );
  }
}

class AnimationSquare extends StatefulWidget {
  const AnimationSquare({super.key});

  @override
  State<AnimationSquare> createState() => _AnimationSquareState();
}

class _AnimationSquareState extends State<AnimationSquare> {
  int size = 100;
  bool selected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /* AnimatedSquare(), */
          /* AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            /* height: selected ? 200 : 100,
            width: selected ? 200 : 100, */
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selected = !selected;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                /* width: selected ? 200 : 100,
                height: selected ? 10 : 100, */
                color: Colors.green,
                child: Text('Hola'),
              ),
            ),
            left: selected ? 10 : 5,
            top: selected ? 100 : null,
            bottom: selected ? 10 : 0,
          ), */
          Positioned(
            bottom: 10,
            left: 10,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selected = !selected;
                });
              },
              child: AnimatedContainer(
                curve: Curves.easeOutCirc,
                duration: const Duration(milliseconds: 200),
                width: selected ? 200 : 100,
                height: selected ? 200 : 100,
                color: Colors.green,
                child: Text('Hola'),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                print(details);
                setState(() {
                  size = size + details.delta.dy.toInt();
                });
              },
              onVerticalDragEnd: (details) {
                if (size > 500) {
                  setState(() {
                    size = 500;
                  });
                } else {
                  setState(() {
                    size = 100;
                  });
                }
              },
              child: AnimatedContainer(
                curve: Curves.decelerate,
                duration: const Duration(milliseconds: 300),
                width: double.infinity,
                height: size.toDouble(),
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
