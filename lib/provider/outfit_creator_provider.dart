part of './providers.dart';

class OutfitCreatorProvider with ChangeNotifier {
  SelectedOutfit state = SelectedOutfit(images: []);
  void updateProductImage(List<String> pathImages) {
    state = state.copyWith(
      images: pathImages,
    );
    notifyListeners();
  }

  Future<void> deleteImage(String imagePath) async {
    state = state.copyWith(
      images: state.images.where((image) => image != imagePath).toList(),
    );
    notifyListeners();
  }
}

class SelectedOutfit {
  List<String> images = [];
  SelectedOutfit({
    required this.images,
  });

  SelectedOutfit copyWith({
    List<String>? images,
  }) =>
      SelectedOutfit(
        images: images ?? this.images,
      );
}
