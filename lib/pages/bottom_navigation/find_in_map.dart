part of '../pages.dart';

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  late LatLng _currentPosition;
  late GoogleMapController mapController;
  Set<Marker> _markers = {};

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    permisionRequest();
  }

  void setCurrentPosition() {
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
      ),
    );
  }

  void permisionRequest() async {
    final status = await Permission.location.request();
    accesoGPS(status);
    await setCurrentMarker();
  }

  setCurrentMarker() async {
    final location = await getLocation();

    setState(() {
      _currentPosition = location;
      _isLoading = false;
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
        ),
      );
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

  Future<MarkerModelImage> getStoresAround(String searchQuery) async {
    final mettersAround = 2000;
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
        final mapsFinderProvider = context.watch<MapsFinderProvider>();
        return Container(
          height: size.height * 0.27,
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
                      mapsFinderProvider.clearSelected();
                    },
                    child: const Text('Limpiar'),
                  ),
                  Text(
                    'Filtrar',
                    style: textTheme.titleSmall,
                  ),
                ],
              ),
              MultipleChoiceChip(
                options: places,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: context.pop,
                    child: const Text('Cancelar'),
                  ),
                  TextButton(
                    onPressed: () async {
                      await setMakers(mapsFinderProvider);
                    },
                    child: const Text('Hecho'),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Future setMakers(MapsFinderProvider mapsFindProvider) async {
    final uploadJob =
        mapsFindProvider.getSelectedPlacesCount.map(getStoresAround).toList();
    final newImages = await Future.wait(uploadJob);

    setState(() {
      _markers = newImages.expand((element) => element.result).map((e) {
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
    });
    context.pop();
  }
}
