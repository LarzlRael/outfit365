part of '../widgets.dart';

class FullScreenPlayer extends StatefulWidget {
  final String videoUrl;
  final String caption;

  const FullScreenPlayer({
    super.key,
    required this.videoUrl,
    required this.caption,
  });

  @override
  State<FullScreenPlayer> createState() => _FullScreenPlayerState();
}

class _FullScreenPlayerState extends State<FullScreenPlayer> {
  late VideoPlayerController controller;

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.network(widget.videoUrl)
      ..setVolume(0)
      ..setLooping(true)
      ..play();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isVideoPlaying = context.watch<DiscoverProvider>();
    return FutureBuilder(
      future: controller.initialize(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Center(
            child: Image.asset(
              'assets/loadings/makeup_loading.gif,',
            ),
          );
        }

        return GestureDetector(
          onTap: () {
            if (controller.value.isPlaying) {
              controller.pause();
              isVideoPlaying.setIsVideoPlaying = false;
              return;
            }
            controller.play();
            isVideoPlaying.setIsVideoPlaying = true;
          },
          child: AspectRatio(
            aspectRatio: controller.value.aspectRatio,
            child: Stack(
              children: [
                VideoPlayer(
                  controller,
                ),
                VideoBackground(
                  stops: const [0.8, 1.0],
                ),
                Positioned(
                  bottom: 50,
                  left: 20,
                  child: _VideoCaption(
                    caption: widget.caption,
                  ),
                ),
                /* Positioned(
                  top: 10,
                  left: 10,
                  child: IconButton(
                    icon: Icon(
                      isVideoPlaying.isMuted
                          ? Icons.volume_off
                          : Icons.volume_up,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      isVideoPlaying.setIsMuted();
                      controller.setVolume(
                        isVideoPlaying.isMuted ? 0 : 1,
                      );
                    },
                  ),
                ), */
              ],
            ),
          ),
        );
      },
    );
  }
}

class _VideoCaption extends StatelessWidget {
  final String caption;
  const _VideoCaption({
    Key? key,
    required this.caption,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final titleStyle = Theme.of(context).textTheme.titleLarge;
    return SizedBox(
      width: size.width * 0.6,
      child: Text(
        caption,
        maxLines: 2,
        style: titleStyle!.copyWith(
          color: Colors.white,
          /* fontWeight: FontWeight.bold, */
        ),
      ),
    );
  }
}
