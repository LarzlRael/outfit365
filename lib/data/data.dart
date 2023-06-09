import 'dart:math';

final List<String> cloths = [
  "assets/animated.glb",
  "assets/punk_girl.glb",
  "assets/animated_woman2.glb",
  "assets/t-shirt.glb",
];

gerRandomCloth() {
  final random = Random();
  final index = random.nextInt(cloths.length);
  return cloths[index];
}
