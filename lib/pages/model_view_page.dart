part of './pages.dart';

class ModelViewPage extends StatefulWidget {
  /* final String? cloth; */
  const ModelViewPage({super.key});

  @override
  State<ModelViewPage> createState() => _ModelViewPageState();
}

class _ModelViewPageState extends State<ModelViewPage> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              ModelView(cloth: 'assets/animated_woman2.glb'),
              Positioned(
                top: 15,
                left: 15,
                child: IconButton(
                  onPressed: () {
                    context.pop();
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: 20,
                    color: Colors.grey,
                  ),
                ),
              ),
              Positioned(
                right: 10,
                /* change this depends of items, */
                top: size.height * 0.15,
                child: Container(
                  width: size.width * 0.2,
                  height: size.height * 0.7,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [1, 2, 3, 4]
                          .map(
                            (e) => GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedIndex = e;
                                });
                              },
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(
                                    color: selectedIndex == e
                                        ? Colors.orange
                                        : Colors.transparent,
                                    width: 1.5,
                                  ),
                                ),
                                margin: EdgeInsets.only(bottom: 10),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    'https://www.helikon-tex.com/media/catalog/product/cache/4/image/9df78eab33525d08d6e5fb8d27136e95/s/p/sp-pgm-dc-11.jpg',
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ModelView extends StatelessWidget {
  const ModelView({
    super.key,
    required this.cloth,
  });

  final String? cloth;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.75,
      child: ModelViewer(
        src: cloth!,
        alt: "A 3D model of an astronaut",
        ar: true,
        autoRotate: true,
        cameraControls: true,
      ),
    );
  }
}
