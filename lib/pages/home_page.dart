part of 'pages.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final outfitCreatorProvider = context.watch<OutfitCreatorProvider>();
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(appName),
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
              tabItem("Outfits"),
              tabItem("Maquillaje"),
              tabItem("Ropa y maquillaje"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Scaffold(
              floatingActionButton: FloatingActionButton.extended(
                onPressed: () {
                  context.push('/pick_outfit');
                },
                icon: Icon(Icons.add),
                label: Text('Crea tu propio outfit'),
              ),
              body: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: double.infinity,
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    15,
                    15,
                    15,
                    0,
                  ),
                  child: AlignedGridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 25,
                    itemCount: categoryOptions(context).length,
                    itemBuilder: (context, index) =>
                        categoryOptions(context)[index],
                  ),
                ),
              ),
            ),
            MakeupPage(),
            MapPresentation(),
          ],
        ),
      ),
    );
  }
}

Widget tabItem(String title) {
  return Tab(
    child: Container(
      /* padding: EdgeInsets.symmetric(horizontal: 5), */
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        border: Border.all(
          color: Colors.orange,
          width: 1,
        ),
      ),
      child: Align(
        alignment: Alignment.center,
        child: Flexible(
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
    ),
  );
}
