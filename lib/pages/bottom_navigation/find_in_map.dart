part of '../pages.dart';

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  LatLng? _currentPosition;
  late GoogleMapController mapController;
  @override
  void initState() {
    super.initState();
    permisionRequest();
    getLocation();
    selectedPlace = places[0];
  }

  void permisionRequest() async {
    final status = await Permission.location.request();
    accesoGPS(status);
  }

  getLocation() async {
    LocationPermission permission;
    permission = await Geolocator.requestPermission();

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    double lat = position.latitude;
    double long = position.longitude;

    LatLng location = LatLng(lat, long);

    setState(() {
      _currentPosition = location;
      /* _isLoading = false; */
    });
  }

  Set<Marker> _markers = {};
  final List<String> places = [
    'zapatos',
    'maquillaje',
    'ropa de mujer',
    'lenceria',
  ]; // Option 2
  late String selectedPlace; // Option 2
  void addMarker() {
    Marker newMarker = Marker(
      markerId: MarkerId('marker_id'),
      position: _currentPosition!,
      infoWindow: InfoWindow(
          title: 'Título del marcador', snippet: 'Descripción del marcador'),
      // Otros atributos opcionales como icono personalizado, etc.
    );
    setState(() {
      _markers.add(newMarker);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentPosition == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                GoogleMap(
                  mapType: MapType.normal,
                  /* set marker */
                  markers: _markers,
                  initialCameraPosition: _currentPosition != null
                      ? CameraPosition(
                          target: _currentPosition!,
                          zoom: 16,
                        )
                      : const CameraPosition(
                          target: LatLng(0, 0),
                          zoom: 16,
                        ),
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                    mapController = controller;
                  },
                ),
                Positioned(
                  top: MediaQuery.of(context).padding.top + 20,
                  child: DropdownButton(
                    value: selectedPlace,
                    items: places.map((String value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (option) async {
                      print(option);
                      setState(() {
                        selectedPlace = option!;
                      });
                      await getStoresAround();
                    },
                  ),
                ),
              ],
            ),
      floatingActionButton: Column(
        children: [
          FloatingActionButton(
            child: const Icon(Icons.pin_drop),
            onPressed: () {
              mapController.animateCamera(
                CameraUpdate.newLatLngZoom(
                  LatLng(
                      _currentPosition!.latitude, _currentPosition!.longitude),
                  17,
                ),
              );
            },
          ),
          FloatingActionButton(
            onPressed: () async {
              await getStoresAround();
            },
            child: const Icon(Icons.search),
          )
        ],
      ),
    );
  }

  void accesoGPS(PermissionStatus status) {
    switch (status) {
      case PermissionStatus.granted:
        /* Navigator.pushReplacementNamed(context, 'mapa'); */
        break;

      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.limited:
      case PermissionStatus.permanentlyDenied:
        openAppSettings();
        break;
    }
  }

  Future<void> getStoresAround() async {
    String url =
        "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${_currentPosition!.latitude},${_currentPosition!.longitude}&radius=500&keyword=${selectedPlace}&key=AIzaSyAC6Xr2EAl6tsoR3_CsWqqGYYAM3SCR9xA";

    final uri = Uri.parse(url);
    var response = await http.get(uri);
    final models = markerModelFromJson(response.body);
    setState(
      () {
        _markers = models.results.map((e) {
          return Marker(
            markerId: MarkerId(e.name),
            position: LatLng(e.geometry.location.lat, e.geometry.location.lng),
            infoWindow: InfoWindow(
              title: e.name,
              snippet: e.vicinity,
            ),
          );
        }).toSet();
        _markers.add(
          Marker(
            markerId: MarkerId('marker_id'),
            position: _currentPosition!,
            infoWindow: InfoWindow(
                title: 'Título del marcador',
                snippet: 'Descripción del marcador'),
            // Otros atributos opcionales como icono personalizado, etc.
          ),
        );
      },
    );
  }
}
