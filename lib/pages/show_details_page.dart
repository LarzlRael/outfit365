part of './pages.dart';

class QueryAndTitle {
  final String queryToSearch;
  final String title;
  final String category;
  QueryAndTitle({
    required this.queryToSearch,
    required this.title,
    required this.category,
  });
}

class ShowDetailsPage extends StatefulWidget {
  final QueryAndTitle queryToSearch;
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
    setState(() {
      listImages = obtenerImagenesPorCategoria(widget.queryToSearch.category);
      isLoading = false;
    });
  }

  List<String> listImages = [];
  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.queryToSearch.title),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
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
                      child: FadeInImage(
                        placeholder:
                            AssetImage('assets/loadings/bottle_loader.gif'),
                        image: AssetImage(
                          listImages[index],
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }

  /* Future<List<String>> getImagesFromWeb(String searchQuery) async {
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
  } */
}
