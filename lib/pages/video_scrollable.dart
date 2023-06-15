part of './pages.dart';

class VideoScrollabelView extends StatelessWidget {
  final List<VideoNCaption> videos;

  VideoScrollabelView({
    super.key,
    required this.videos,
  });
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      itemCount: videos.length,
      itemBuilder: (context, index) {
        final videoPost = videos[index];
        return Stack(
          children: [
            SizedBox.expand(
              child: FullScreenPlayer(
                caption: videoPost.caption,
                videoUrl: videoPost.videoPath,
              ),
            ),
            Positioned(
              bottom: 40,
              right: 20,
              child: VideoButtons(
                video: videoPost.caption,
              ),
            ),
          ],
        );
      },
    );
  }
}
