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
                mapsFinderProvider.getIsFething
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
                          await setMarkers(mapsFinderProvider);
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

  Future setMarkers(MapsFinderProvider mapsFindProvider) async {
    await mapsFindProvider.setFetchMarkers();
    context.pop();
  }
}
