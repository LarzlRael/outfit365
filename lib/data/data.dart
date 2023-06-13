import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:outfilt/pages/pages.dart';

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

List<Widget> categoryOptions(BuildContext context) {
  return [
    CircleButton(
      text: 'Citas',
      imageSrc:
          "https://i.pinimg.com/236x/8d/82/09/8d820948ef1a53703898177025641a99.jpg",
      onPressed: () {
        context.push('/show_details_page',
            extra:
                QueryAndTitle(queryToSearch: "women outfit", title: 'Citas'));
      },
    ),
    CircleButton(
      imageSrc:
          "https://i.pinimg.com/originals/9f/1e/3f/9f1e3f2e680def30285a04f85adbde25.jpg",
      text: 'Trabajo',
      onPressed: () {
        context.push('/show_details_page',
            extra:
                QueryAndTitle(queryToSearch: "mujer empleo", title: 'Trabajo'));
      },
    ),
    CircleButton(
      imageSrc:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSQ2U-Cyp9lM5FBdV3sIZ7hDoF8w3-tsYhFxw&usqp=CAU",
      text: 'Reunion con amigos',
      onPressed: () {
        context.push('/show_details_page',
            extra:
                QueryAndTitle(queryToSearch: "women outfit", title: 'Reunion'));
      },
    ),
    CircleButton(
      imageSrc:
          "https://i.pinimg.com/736x/a9/33/fc/a933fc8a747257936cfe23ea6d462e46.jpg",
      text: 'Fiestas',
      onPressed: () {
        context.push('/show_details_page',
            extra:
                QueryAndTitle(queryToSearch: "party outfit", title: 'Fiestas'));
      },
    ),
    CircleButton(
      imageSrc:
          "https://begood.store/1999-new_prod_big/women-s-sport-suit-reversible-bra-melange-legging.jpg",
      text: 'Deportes',
      onPressed: () {
        context.push('/show_details_page',
            extra: QueryAndTitle(
                queryToSearch: "sport outfit", title: 'Deportes'));
      },
    ),
  ];
}
