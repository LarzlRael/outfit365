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
    final imagesSelected = context.read<OutfitCreatorProvider>().state.images;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Stack(
            children: [
              ModelView(cloth: gerRandomCloth()),
              Positioned(
                top: 15,
                left: 15,
                child: IconButton(
                  onPressed: context.pop,
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
                      children: imagesSelected.map((e) {
                        var index = imagesSelected.indexOf(e);
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                            });
                          },
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(
                                color: selectedIndex == index
                                    ? Colors.orange
                                    : Colors.transparent,
                                width: 2,
                              ),
                            ),
                            margin: EdgeInsets.only(bottom: 10),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                File(e),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: Container(
                  height: size.height * 0.20,
                  width: size.width * 1,
                  child: Column(
                    children: [
                      /* Text(
                        "Outfit Creator",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Choose your outfit",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                      ), */
                      ListTile(
                        title: Text(
                          "Outfit Creator",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          "Choose your outfit",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        trailing: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
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
/*         loading: Loading.lazy, */
        src: cloth!,
        alt: "A 3D model of an astronaut",
        ar: true,
        autoRotate: true,
        cameraControls: true,
      ),
    );
  }
}
