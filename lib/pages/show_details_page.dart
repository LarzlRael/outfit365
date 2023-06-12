part of './pages.dart';

class ShowDetailsPage extends StatefulWidget {
  final String queryToSearch;
  const ShowDetailsPage({
    super.key,
    required this.queryToSearch,
  });

  @override
  State<ShowDetailsPage> createState() => _ShowDetailsPageState();
}

class _ShowDetailsPageState extends State<ShowDetailsPage> {
  @override
  void initState() {
    super.initState();
    getImagesFromWeb(
      widget.queryToSearch,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<String> listImages = [];
  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Show Details Page'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getImagesFromWeb('yellow flowers');
        },
        child: Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: MasonryGridView.count(
          physics: const BouncingScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          itemCount: listImages.length,
          itemBuilder: (context, index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: InstaImageViewer(
                child: Image.network(
                  listImages[index],
                  fit: BoxFit.contain,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<List<String>> getImagesFromWeb(String searchQuery) async {
    final pixabayApiKey = Enviroment.pixabayApiKey;
    final replaceQuery = searchQuery.replaceAll(' ', '+');
    String url =
        "https://pixabay.com/api/?key=${pixabayApiKey}&q=${replaceQuery}&image_type=photo&page=${1}&per_page=30";

    final uri = Uri.parse(url);
    var response = await http.get(uri);
    final models = pixabayModelFromJson(response.body);
    /* return models.results; */
    setState(() {
      listImages = [
        ...listImages,
        ...models.hits.map((e) => e.webformatUrl).toList()
      ];
      isLoading = false;
    });

    return models.hits.map((e) => e.webformatUrl).toList();
  }
}
