part of 'pages.dart';

class HomePage extends StatelessWidget {
  final List<String> cloths = [
    "assets/animated.glb",
    "assets/punk_girl.glb",
    "assets/animated_woman2.glb",
    "assets/t-shirt.glb",
  ];

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final outfitCreatorProvider = context.watch<OutfitCreatorProvider>();
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text(appName),
            backgroundColor: Colors.white,
            elevation: 0,
            bottom: TabBar(
              labelColor: Colors.white,
              unselectedLabelColor: Colors.orange,
              indicatorSize: TabBarIndicatorSize.label,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.orange,
              ),
              tabs: [
                tabItem("Shop Men"),
                tabItem("Show Woman"),
                tabItem("Shop kids"),
              ],
            ),
          ),
          body: TabBarView(children: [
            Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 250,
                    width: 600,
                    child: ImageGallery(
                      images: outfitCreatorProvider.state.images,
                      deleteImage: (path) {
                        outfitCreatorProvider.deleteImage(path);
                      },
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      final photoPath =
                          await CamerGalleryServiceImp().selectFromGallery();
                      if (photoPath == null) return;
                      /* productProvider.updateProductImage(photoPath); */
                      outfitCreatorProvider.updateProductImage(photoPath);
                    },
                    icon: const Icon(Icons.photo_album),
                  ),
                  /* TextButton(
                    onPressed: () {
                      context.push('/modelviewer');
                    },
                    child: Text('Que fueg'),
                  ), */
                ],
              ),
            ),
            Icon(Icons.movie),
            Icon(Icons.games),
          ]),
        ));
  }
}

Widget tabItem(String title) {
  return Tab(
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        border: Border.all(
          color: Colors.orange,
          width: 1,
        ),
      ),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            /* color: Colors.white, */
          ),
          textAlign: TextAlign.center,
        ),
      ),
    ),
  );
}
