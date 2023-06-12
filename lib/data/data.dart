import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widgets/widgets.dart';

final List<String> cloths = [
  /* e */
  "assets/girl.glb",
];

gerRandomCloth() {
  final random = Random();
  final index = random.nextInt(cloths.length);
  return cloths[index];
}

List<Widget> registerOptions(BuildContext context) {
  return [
    CircleButton(
      text: 'Citas',
      imageSrc:
          "https://outfittrends.b-cdn.net/wp-content/uploads/2016/10/Lovely-day-Time-Date-Outfits-27.jpg",
      onPressed: () {
        context.push('/list_products_page');
      },
    ),
    CircleButton(
      imageSrc:
          "https://i.pinimg.com/originals/9f/1e/3f/9f1e3f2e680def30285a04f85adbde25.jpg",
      text: 'Trabajo',
      onPressed: () {
        context.push('/categories_page');
      },
    ),
    CircleButton(
      imageSrc:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSQ2U-Cyp9lM5FBdV3sIZ7hDoF8w3-tsYhFxw&usqp=CAU",
      text: 'Reunion con amigos',
      onPressed: () {
        context.push('/materials_page');
      },
    ),
    CircleButton(
      imageSrc:
          "https://i.pinimg.com/736x/a9/33/fc/a933fc8a747257936cfe23ea6d462e46.jpg",
      text: 'Fiestas',
      onPressed: () {
        context.push('/clients_page');
      },
    ),
  ];
}
