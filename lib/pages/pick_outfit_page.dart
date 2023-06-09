part of './pages.dart';

class PickOutfitPage extends StatelessWidget {
  const PickOutfitPage({super.key});
  @override
  Widget build(BuildContext context) {
    final outfitCreatorProvider = Provider.of<OutfitCreatorProvider>(context);
    return Scaffold(
      floatingActionButton: outfitCreatorProvider.state.images.isEmpty
          ? null
          : FloatingActionButton.extended(
              onPressed: () {
                context.push('/modelviewer');
              },
              icon: Icon(Icons.check),
              label: Text(
                'Generar Outfit',
              ),
            ),
      appBar: AppBar(
        title: Text('Creador de Outfit'),
        actions: [
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
            TextButton(
              onPressed: () {
                context.push('/modelviewer');
              },
              child: Text('Ver outfit'),
            ),
          ],
        ),
      ),
    );
  }
}
