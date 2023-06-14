part of './providers.dart';

class OutfitCreatorProvider with ChangeNotifier {
  final colors = [
    Colors.orange,
    Colors.blue,
  ];
  SelectedOutfit state = SelectedOutfit(
    images: [],
    currentImageColor: 1,
    currentColor: Colors.orange,
  );

  final limitImages = 3;
  void updateCurrentImageColor() {
    if (state.currentImageColor == limitImages) {
      state = state.copyWith(
        currentImageColor: 1,
        currentColor: colors[state.currentImageColor - 1],
      );
      return;
    }
    state = state.copyWith(
      currentImageColor: state.currentImageColor + 1,
    );

    notifyListeners();
  }

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
  int currentImageColor = 1;
  Color currentColor = Colors.orange;

  SelectedOutfit({
    required this.images,
    required this.currentImageColor,
    required this.currentColor,
  });

  SelectedOutfit copyWith(
          {List<String>? images,
          int? currentImageColor,
          Color? currentColor}) =>
      SelectedOutfit(
        images: images ?? this.images,
        currentImageColor: this.currentImageColor,
        currentColor: currentColor ?? this.currentColor,
      );
}
