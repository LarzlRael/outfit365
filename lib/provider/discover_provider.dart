part of './providers.dart';

class DiscoverProvider extends ChangeNotifier {
  bool initialLoading = true;
  List<String> videos = [];
  bool _isVideoPlaying = true;
  bool _isMuted = false;

  Future<void> loadNextPage() async {
    //TODO: cargar videos
    /* await Future.delayed(const Duration(seconds: 2)); */

// this is changed by the repository data source
    /* final List<VideoPost> newVideos = videoPosts
        .map((video) => LocalVideoModel.fromJson(video).toVideoPostEntity())
        .toList();
 */

    initialLoading = false;
    notifyListeners();
  }

  bool get isVideoPlaying => _isVideoPlaying;
  bool get isMuted => _isMuted;
  setIsMuted() {
    _isMuted = !_isMuted;
    notifyListeners();
  }

  set setIsVideoPlaying(bool value) {
    _isVideoPlaying = value;
    notifyListeners();
  }
}
