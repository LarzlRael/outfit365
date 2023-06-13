part of '../widgets.dart';

class ControlerCircularProgressIndicator extends StatelessWidget {
  final VoidCallback? onTimerFinish;
  const ControlerCircularProgressIndicator({
    super.key,
    this.onTimerFinish,
  });
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Stream.periodic(
        const Duration(milliseconds: 100),
        (value) {
          return (value * 2) / 100;
        },
      ).takeWhile((value) => value < 100),
      builder: (context, snapshot) {
        final progress = snapshot.data ?? 0.0;
        if (progress == 1.0) {
          // Ejecutar la función de callback cuando el timer termine
          if (onTimerFinish != null) {
            onTimerFinish!();
          }
        }
        return Container(
          width: 45,
          height: 45,
          child: SizedBox(
            child: CircularProgressIndicator(
              strokeWidth: 2,
              backgroundColor: Colors.black12,
              value: progress,
            ),
          ),
        );
      },
    );
  }
}
