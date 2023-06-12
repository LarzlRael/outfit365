part of './providers.dart';

class MapsFinderProvider with ChangeNotifier {
  List<String> selectedPlaces = [];

  List<String> get getSelectedPlacesCount => selectedPlaces;

  addOrRemoveElement(String item) {
    selectedPlaces.contains(item)
        ? selectedPlaces.remove(item)
        : selectedPlaces.add(item);
    notifyListeners();
  }

  void clearSelected() {
    selectedPlaces.clear();
    notifyListeners();
  }
}
