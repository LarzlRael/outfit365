part of './providers.dart';

class OutfitCreatorProvider with ChangeNotifier {
  final colors = [
    Colors.black,
    Colors.orange,
    Colors.blue,
  ];

  final List<String> cloths = [
    /* e */
    "assets/3d/girl.glb",
    "assets/3d/suit.glb",
    "assets/3d/animated_woman2.glb",
  ];

  SelectedOutfit state = SelectedOutfit(
    images: [],
    currentImageColor: 0,
    currentColor: Colors.black,
    currentCloth: "assets/3d/girl.glb",
  );
  int currentImageColor = 0;
  get getCurrentImageColor => currentImageColor;

  updateCurrentImageColor() {
    currentImageColor == colors.length - 1
        ? currentImageColor = 0
        : currentImageColor++;

    state = state.copyWith(
      currentColor: colors[currentImageColor],
      currentCloth: cloths[currentImageColor],
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
  String currentCloth = "assets/3d/girl.glb";

  SelectedOutfit({
    required this.images,
    required this.currentImageColor,
    required this.currentColor,
    required this.currentCloth,
  });

  SelectedOutfit copyWith({
    List<String>? images,
    int? currentImageColor,
    Color? currentColor,
    String? currentCloth,
  }) =>
      SelectedOutfit(
        images: images ?? this.images,
        currentImageColor: this.currentImageColor,
        currentColor: currentColor ?? this.currentColor,
        currentCloth: currentCloth ?? this.currentCloth,
      );
}
