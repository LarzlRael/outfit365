part of './pages.dart';

class PickOutfitPage extends StatelessWidget {
  const PickOutfitPage({super.key});
  @override
  Widget build(BuildContext context) {
    final outfitCreatorProvider = Provider.of<OutfitCreatorProvider>(
      context,
      listen: true,
    );
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      floatingActionButton: outfitCreatorProvider.state.images.length >= 2
          ? FloatingActionButton.extended(
              onPressed: () {
                outfitCreatorProvider.updateCurrentImageColor();
                showLoaderDialog(context);
              },
              icon: Icon(Icons.check),
              label: Text(
                'Crear outfit',
              ),
            )
          : null,
      appBar: AppBar(
        title: Text('Creador de Outfit'),
        actions: [
          CircleAvatar(
            radius: 10,
            backgroundColor: outfitCreatorProvider.state.currentColor,
          ),
          IconButton(
            onPressed: () async {
              final photoPath =
                  await CamerGalleryServiceImp().selectFromGallery();
              if (photoPath == null) return;
              outfitCreatorProvider.updateProductImage(photoPath);
            },
            icon: const Icon(Icons.photo_album),
          ),
          IconButton(
            onPressed: () async {
              final photoPath = await CamerGalleryServiceImp().takePhoto();
              if (photoPath == null) return;
              outfitCreatorProvider.updateProductImage([photoPath]);
            },
            icon: const Icon(Icons.camera_alt),
          ),
        ],
      ),
      body: Container(
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
            outfitCreatorProvider.state.images.length < 2
                ? SimpleText(
                    text: 'Agrega al menos 2 imagenes para crear tu outfit',
                    style: textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  )
                : SizedBox(),
            outfitCreatorProvider.state.images.length >= 2
                ? SimpleText(
                    text:
                        'Pulsa el botón de "Crear outfit" para crear tu outfit',
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    style: textTheme.titleSmall,
                    textAlign: TextAlign.center,
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }

  showLoaderDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            width: 150,
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 20),
                Text('Creando outfit...'),
              ],
            ),
          ),
        );
      },
    );

    Future.delayed(Duration(seconds: 2), () {
      context.pop();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ModelViewPage()),
      );
    });
  }
}
