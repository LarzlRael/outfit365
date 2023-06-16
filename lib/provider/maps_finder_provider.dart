part of './providers.dart';

class MapsFinderProvider with ChangeNotifier {
  late LatLng _currentPosition;
  List<String> _selectedPlaces = [];
  Set<Marker> _markers = {};
  List<String> get getSelectedPlaces => _selectedPlaces;
  Set<Marker> get getCurrentMarkers => _markers;

  LatLng get getCurrentPosition => _currentPosition;
  bool _isFetching = false;

  bool get getIsFething => _isFetching;
  set setIsFetching(bool value) {
    _isFetching = value;
    notifyListeners();
  }

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

  Future<List<Marker>> getStoresAround(String searchQuery) async {
    final customIcon = await setCustomIcon(searchQuery);

    final mettersAround = 2000;
    final googleMapApiKey = Enviroment.googleMapsApiKey;
    String url =
        "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${getCurrentPosition.latitude},${getCurrentPosition.longitude}&radius=${mettersAround}&keyword=${searchQuery}&key=${googleMapApiKey}";

    final uri = Uri.parse(url);
    var response = await http.get(uri);
    final models = markerModelFromJson(response.body);
    /* return models.results; */
    return models.results.map((e) {
      return Marker(
        markerId: MarkerId(e.name),
        position: LatLng(
          e.geometry.location.lat,
          e.geometry.location.lng,
        ),
        icon: customIcon,
        infoWindow: InfoWindow(
          title: e.name,
          snippet: e.vicinity,
        ),
      );
    }).toList();
  }

  Future<void> setFetchMarkers() async {
    setIsFetching = true;
    final uploadJob = getSelectedPlaces.map(getStoresAround).toList();
    final newImages = await Future.wait(uploadJob);

    setIsFetching = false;
    setMarkers(
      newImages.expand((element) => element).map((e) {
        return e;
      }).toSet(),
    );
  }
}
