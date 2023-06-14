part of '../pages.dart';

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  late GoogleMapController mapController;

  bool _isLoading = true;
  bool _isFeaching = false;
  late MapsFinderProvider mapsFinderProvider;

  @override
  void initState() {
    super.initState();
    mapsFinderProvider = context.read<MapsFinderProvider>();
    permisionRequest();
    /* WidgetsBinding.instance!.addPostFrameCallback((_) {
      showModalFilter();
    }); */
  }

  void permisionRequest() async {
    final status = await Permission.location.request();
    accesoGPS(status);
    await setCurrentMarker();
  }

  setCurrentMarker() async {
    final location = await getLocation();
    mapsFinderProvider.setCurrentPosition(
      LatLng(
        location.latitude,
        location.longitude,
      ),
    );
    setState(() {
      _isLoading = false;
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
          ? Center(
              child: Image.asset('assets/loadings/makeup_loading.gif'),
            )
          : Stack(
              children: [
                Consumer<MapsFinderProvider>(
                  builder: (_, mapsFinderProvider, child) {
                    return GoogleMap(
                      mapType: MapType.normal,
                      /* set marker */
                      markers: mapsFinderProvider.getCurrentMarkers,
                      initialCameraPosition: CameraPosition(
                        target: mapsFinderProvider.getCurrentPosition,
                        zoom: 16,
                      ),
                      onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                        mapController = controller;
                      },
                    );
                  },
                ),
                _isFeaching
                    ? Opacity(
                        opacity: 0.6, // Valor de opacidad (0.0 a 1.0)
                        child: Container(
                          color: Colors.black, // Color oscuro
                        ),
                      )
                    : SizedBox(),
              ],
            ),
    );
  }

  Future<MarkerModelImage> getStoresAround(String searchQuery) async {
    final mettersAround = 2000;
    final googleMapApiKey = Enviroment.googleMapsApiKey;
    String url =
        "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${mapsFinderProvider.getCurrentPosition.latitude},${mapsFinderProvider.getCurrentPosition.longitude}&radius=${mettersAround}&keyword=${searchQuery}&key=${googleMapApiKey}";

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
      'salon de belleza',
    ];
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        final size = MediaQuery.of(context).size;
        final textTheme = Theme.of(context).textTheme;
        final mapsFinderProvider = context.watch<MapsFinderProvider>();
        return Container(
          height: size.height * 0.35,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: EdgeInsets.only(top: 5),
                  width: 40,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Column(
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
            ],
          ),
        );
      },
    );
  }

  Future setMakers(MapsFinderProvider mapsFindProvider) async {
    setState(() {
      _isFeaching = true;
    });
    final uploadJob =
        mapsFindProvider.getSelectedPlaces.map(getStoresAround).toList();
    final newImages = await Future.wait(uploadJob);

    mapsFindProvider.setMarkers(
      newImages.expand((element) => element.result).map((e) {
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
      }).toSet(),
    );
    setState(() {
      _isFeaching = false;
    });
    context.pop();
  }
}
