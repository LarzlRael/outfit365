part of '../pages.dart';

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
    bearing: 192.8334901395799,
    target: LatLng(37.43296265331129, -122.08832357078792),
    tilt: 59.440717697143555,
    zoom: 19.151926040649414,
  );
  LatLng? _currentPosition;
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
      /* _isLoading = false; */
    });
  }

  Set<Marker> _markers = {};
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
          : GoogleMap(
              mapType: MapType.normal,
              /* set marker */
              markers: _markers,
              initialCameraPosition: _currentPosition != null
                  ? CameraPosition(
                      target: _currentPosition!,
                      zoom: 16,
                    )
                  : _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.push('/find_map');
        },
        label: const Text('Ir a la pagina'),
        icon: const Icon(Icons.directions_boat),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
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
}
