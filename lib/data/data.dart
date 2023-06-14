import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:outfilt/pages/pages.dart';

import '../widgets/widgets.dart';

List<Widget> categoryOptions(BuildContext context) {
  return [
    CircleButton(
      text: 'Citas',
      imageSrc:
          "https://i.pinimg.com/236x/8d/82/09/8d820948ef1a53703898177025641a99.jpg",
      onPressed: () {
        context.push('/show_details_page',
            extra: QueryAndTitle(
                queryToSearch: "women outfit",
                title: 'Citas',
                category: 'dates'));
      },
    ),
    CircleButton(
      imageSrc:
          "https://i.pinimg.com/originals/9f/1e/3f/9f1e3f2e680def30285a04f85adbde25.jpg",
      text: 'Trabajo',
      onPressed: () {
        context.push('/show_details_page',
            extra: QueryAndTitle(
                queryToSearch: "mujer empleo",
                title: 'Trabajo',
                category: 'work'));
      },
    ),
    CircleButton(
      imageSrc:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSQ2U-Cyp9lM5FBdV3sIZ7hDoF8w3-tsYhFxw&usqp=CAU",
      text: 'Reunion con amigos',
      onPressed: () {
        context.push('/show_details_page',
            extra: QueryAndTitle(
                queryToSearch: "women outfit",
                title: 'Reunion',
                category: 'friend'));
      },
    ),
    CircleButton(
      imageSrc:
          "https://i.pinimg.com/736x/a9/33/fc/a933fc8a747257936cfe23ea6d462e46.jpg",
      text: 'Fiestas',
      onPressed: () {
        context.push('/show_details_page',
            extra: QueryAndTitle(
                queryToSearch: "party outfit",
                title: 'Fiestas',
                category: 'party'));
      },
    ),
    CircleButton(
      imageSrc:
          "https://begood.store/1999-new_prod_big/women-s-sport-suit-reversible-bra-melange-legging.jpg",
      text: 'Deportes',
      onPressed: () {
        context.push('/show_details_page',
            extra: QueryAndTitle(
              queryToSearch: "sport outfit",
              title: 'Deportes',
              category: 'sport',
            ));
      },
    ),
  ];
}

class CategoryByImage {
  final String categoryName;
  final List<String> images;

  CategoryByImage(this.categoryName, this.images);
}

List<CategoryByImage> categorias = [
  CategoryByImage('work', [
    'assets/outfits/work_1.jpeg',
    'assets/outfits/work_2.jpeg',
    'assets/outfits/work_3.jpeg',
    'assets/outfits/work_4.jpeg',
    'assets/outfits/work_5.jpeg',
  ]),
  CategoryByImage('dates', [
    'assets/outfits/date_1.jpeg',
    'assets/outfits/date_2.jpeg',
    'assets/outfits/date_3.jpeg',
    'assets/outfits/date_4.jpeg',
    'assets/outfits/date_5.jpeg',
  ]),
  CategoryByImage('friend', [
    'assets/outfits/friends_1.jpeg',
    'assets/outfits/friends_2.jpeg',
    'assets/outfits/friends_3.jpeg',
    'assets/outfits/friends_4.jpeg',
    'assets/outfits/friends_5.jpeg',
  ]),
  CategoryByImage('party', [
    'assets/outfits/party_1.jpeg',
    'assets/outfits/party_2.jpeg',
    'assets/outfits/party_3.jpeg',
    'assets/outfits/party_4.jpeg',
    'assets/outfits/party_5.jpeg',
    'assets/outfits/party_6.jpeg',
  ]),
  CategoryByImage('sport', [
    'assets/outfits/sport_1.jpeg',
    'assets/outfits/sport_2.jpeg',
    'assets/outfits/sport_3.jpeg',
    'assets/outfits/sport_4.jpeg',
    'assets/outfits/sport_5.jpeg',
    'assets/outfits/sport_6.jpeg',
  ]),
];

List<String> obtenerImagenesPorCategoria(String category) {
  CategoryByImage categoriaSeleccionada =
      categorias.firstWhere((c) => c.categoryName == category);
  return categoriaSeleccionada.images;
}

// Uso de la función obtenerImagenesPorCategoria
/* List<String> imagenesDeCitas = obtenerImagenesPorCategoria('Citas'); */

class VideoNCaption {
  final String videoPath;
  final String caption;

  VideoNCaption(this.videoPath, this.caption);
}

List<VideoNCaption> videoList = [
  VideoNCaption(
    'https://res.cloudinary.com/daij4l3is/video/upload/v1686767070/makupe_network/rrea4g1cg9cjgjv6rriq.mp4',
    'Skincare',
  ),
  VideoNCaption(
    'https://res.cloudinary.com/daij4l3is/video/upload/v1686767062/makupe_network/f1vsc1ndf125qtkpmq8u.mp4',
    'Skincare',
  ),
  VideoNCaption(
    'https://res.cloudinary.com/daij4l3is/video/upload/v1686767061/makupe_network/xnuptypxem22stbl2zsg.mp4',
    'Skincare',
  ),
  VideoNCaption(
    'https://res.cloudinary.com/daij4l3is/video/upload/v1686767052/makupe_network/glytwtszob9l2gvmkude.mp4',
    'Skincare',
  ),
  VideoNCaption(
    'https://res.cloudinary.com/daij4l3is/video/upload/v1686767051/makupe_network/mx5tykwdgyykfbrv9iek.mp4',
    'Maquillaje de ojos',
  ),
  VideoNCaption(
    'https://res.cloudinary.com/daij4l3is/video/upload/v1686767036/makupe_network/amkclrm0gmajrlsyrcse.mp4',
    'Skincare',
  ),
  VideoNCaption(
    'https://res.cloudinary.com/daij4l3is/video/upload/v1686767032/makupe_network/qlqwnagwxecb8zcwu9fp.mp4',
    'Skincare',
  ),
  VideoNCaption(
    'https://res.cloudinary.com/daij4l3is/video/upload/v1686767024/makupe_network/xumuse60ibzf3raol29s.mp4',
    'Maquillaje de labios',
  ),
  VideoNCaption(
    'https://res.cloudinary.com/daij4l3is/video/upload/v1686767023/makupe_network/y7oda34uydoqnrrhwmjr.mp4',
    'Sombreado',
  ),
];

getRandomSuffleVideoList() {
  List<VideoNCaption> videoListCopy = [...videoList];
  videoListCopy.shuffle();
  return videoListCopy;
}
