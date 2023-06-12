part of '../pages.dart';

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  List<String> selectedOptions = [];

  void handleSelectionChanged(List<String> selectedChoices) {
    setState(() {
      selectedOptions = selectedChoices;
    });
  }

  late LatLng _currentPosition;
  late GoogleMapController mapController;
  Set<Marker> _markers = {};

  List<String> selectedPlaces = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    permisionRequest();
    getLocation();
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
      _isLoading = false;
    });
  }

  void addMarker() {
    Marker newMarker = Marker(
      markerId: MarkerId('marker_id'),
      position: _currentPosition,
      infoWindow: InfoWindow(
        title: 'Título del marcador',
        snippet: 'Descripción del marcador',
      ),
      // Otros atributos opcionales como icono personalizado, etc.
    );
    setState(() {
      _markers.add(newMarker);
    });
  }

  clear() {
    setState(() {
      _markers.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.pin_drop),
        onPressed: () {
          /* mapController.animateCamera(
            CameraUpdate.newLatLngZoom(
              LatLng(_currentPosition.latitude, _currentPosition.longitude),
              17,
            ),
          ); */
          showModalFilter();
        },
      ),
      appBar: AppBar(
        title: const Text('Buscar en el mapa'),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                GoogleMap(
                  mapType: MapType.normal,
                  /* set marker */

                  markers: _markers,
                  initialCameraPosition: CameraPosition(
                    target: _currentPosition,
                    zoom: 16,
                  ),
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                    mapController = controller;
                  },
                ),
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

  Future<MarkerModelImage> getStoresAround(String searchQuery) async {
    final mettersAround = 500;
    final googleMapApiKey = Enviroment.googleMapsApiKey;
    String url =
        "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${_currentPosition.latitude},${_currentPosition.longitude}&radius=${mettersAround}&keyword=${searchQuery}&key=${googleMapApiKey}";

    final uri = Uri.parse(url);
    var response = await http.get(uri);
    final models = markerModelFromJson(response.body);
    /* return models.results; */
    return MarkerModelImage(
      icon: imageMap[searchQuery]!,
      result: models.results,
    );
  }

  showModalFilter() {
    final List<String> places = [
      'zapatos',
      'maquillaje',
      'ropa de mujer',
      'lenceria',
    ];
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        final size = MediaQuery.of(context).size;
        final textTheme = Theme.of(context).textTheme;

        return Container(
          height: size.height * 0.25,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        selectedOptions.clear();
                      });
                    },
                    child: const Text('Limpiar'),
                  ),
                  Text(
                    'Filtrar',
                    style: textTheme.titleSmall,
                  ),
                  TextButton(
                    child: const Text('Hecho'),
                    onPressed: () async {
                      final uploadJob =
                          selectedOptions.map(getStoresAround).toList();
                      final newImages = await Future.wait(uploadJob);

                      setState(() {
                        _markers = newImages
                            .expand((element) => element.result)
                            .map((e) {
                          return Marker(
                            markerId: MarkerId(e.name),
                            position: LatLng(
                              e.geometry.location.lat,
                              e.geometry.location.lng,
                            ),
                            infoWindow: InfoWindow(
                              title: e.name,
                              snippet: e.vicinity,
                            ),
                          );
                        }).toSet();
                      });
                      context.pop();
                    },
                  ),
                ],
              ),
              MultipleChoiceChip(
                options: places,
                onSelectionChanged: handleSelectionChanged,
              ),
            ],
          ),
        );
      },
    );
  }
}
