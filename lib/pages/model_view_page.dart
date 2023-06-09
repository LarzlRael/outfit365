part of './pages.dart';

class ModelViewPage extends StatelessWidget {
  final String? cloth;
  const ModelViewPage({super.key, this.cloth});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Model View"),
      ),
      body: Container(
        child: ModelViewer(
          src: cloth!,
          alt: "A 3D model of an astronaut",
          ar: true,
          autoRotate: true,
          cameraControls: true,
        ),
      ),
    );
  }
}
