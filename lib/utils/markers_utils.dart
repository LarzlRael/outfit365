part of 'utils.dart';

void setCustomMarker(String pathImage) async {
  final customIcon = await BitmapDescriptor.fromAssetImage(
    ImageConfiguration(devicePixelRatio: 2.5),
    pathImage,
  );
}

class MarkerModelImage {
  List<Result> result;
  String icon;
  MarkerModelImage({
    required this.result,
    required this.icon,
  });
}

Map<String, String> imageMap = {
  'zapatos': 'assets/store_icons/shoe.png',
  'maquillaje': 'assets/store_icons/makeup.png',
  'ropa de mujer': 'assets/store_icons/woman-clothes.png',
  'lenceria': 'assets/store_icons/lingerie.png',
};
