part of './providers.dart';

class MapsFinderProvider with ChangeNotifier {
  late LatLng _currentPosition;
  List<String> _selectedPlaces = [];
  Set<Marker> _markers = {};
  List<String> get getSelectedPlaces => _selectedPlaces;
  Set<Marker> get getCurrentMarkers => _markers;

  LatLng get getCurrentPosition => _currentPosition;

  addOrRemoveElement(String item) {
    _selectedPlaces.contains(item)
        ? _selectedPlaces.remove(item)
        : _selectedPlaces.add(item);
    notifyListeners();
  }

  setMarkers(Set<Marker> markers) {
    _markers = markers;
    markers.add(
      Marker(
        markerId: MarkerId('marker_id'),
        position: _currentPosition,
        infoWindow: InfoWindow(
          title: 'Tu estás aqui',
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueAzure,
        ),
        // Otros atributos opcionales como icono personalizado, etc.
      ),
    );
    notifyListeners();
  }

  void clearSelected() {
    _selectedPlaces.clear();
    notifyListeners();
  }

  setCurrentPosition(LatLng coordinates) {
    this._currentPosition = coordinates;
    _markers.add(
      Marker(
        markerId: MarkerId('marker_id'),
        position: _currentPosition,
        infoWindow: InfoWindow(
          title: 'Tu estás aqui',
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueAzure,
        ),
        // Otros atributos opcionales como icono personalizado, etc.
      ),
    );
    notifyListeners();
  }
}
