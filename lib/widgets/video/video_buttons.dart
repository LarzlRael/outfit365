part of '../widgets.dart';

class VideoButtons extends StatelessWidget {
  final String video;

  const VideoButtons({
    super.key,
    required this.video,
  });

  @override
  Widget build(BuildContext context) {
    final isVideoPlaying = context.watch<DiscoverProvider>().isVideoPlaying;
    return Column(
      children: [
        _CustomIconButton(
          value: 10,
          icon: Icons.favorite,
          iconColor: Colors.red,
        ),
        SizedBox(height: 20),
        _CustomIconButton(
          value: 10,
          icon: Icons.remove_red_eye_outlined,
        ),
        SizedBox(height: 20),
        SpinPerfect(
          infinite: true,
          /* manualTrigger: false, */
          animate: isVideoPlaying,
          duration: const Duration(
            seconds: 5,
          ),
          child: _CustomIconButton(
            value: 0,
            icon: Icons.play_circle_outline,
          ),
        ),
      ],
    );
  }
}

class _CustomIconButton extends StatelessWidget {
  final int value;
  final IconData icon;
  final Color color;

  const _CustomIconButton({
    required this.value,
    required this.icon,
    iconColor,
  }) : color = iconColor ?? Colors.white;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            icon,
            size: 30,
          ),
          color: color,
        ),
        /* TODO change this */
        /* if (value > 0)
          Text(
            HumanFormats.humanReadbleNumer(value.toDouble()),
            style: TextStyle(color: color),
          ), */
      ],
    );
  }
}
