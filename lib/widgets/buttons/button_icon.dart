part of '../widgets.dart';

class ButtonIcon extends StatelessWidget {
  final String textButton;
  final IconData icon;
  final void Function()? onPressed;
  final double? rotation;
  const ButtonIcon({
    super.key,
    required this.textButton,
    required this.icon,
    this.onPressed,
    this.rotation = 0.0,
  });
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SizedBox(
      width: 150,
      height: 50,
      child: FilledButton(
        /* onPressed: () {
          context.push('/find_map');
        }, */
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              textButton,
              style: textTheme.titleSmall!.copyWith(
                fontSize: 15,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
            Transform.rotate(
              angle: rotation! * math.pi / 180,
              child: Icon(
                icon,
                size: 20,
              ),
            )
          ],
        ),
      ),
    );
  }
}
