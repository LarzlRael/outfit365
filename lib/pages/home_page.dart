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
          title: Material(
            child: Row(
              children: [
                Hero(
                  tag: logoSrc,
                  child: Image.asset(
                    logoSrc,
                    width: 60,
                    height: 60,
                  ),
                ),
                SizedBox(width: 5),
                Hero(
                  tag: appName,
                  child: Text(
                    appName,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(),
                  ),
                ),
              ],
            ),
          ),
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
              body: Container(
                child: AlignedGridView.count(
                  padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
                  crossAxisCount: 2,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 25,
                  itemCount: categoryOptions(context).length,
                  itemBuilder: (context, index) =>
                      categoryOptions(context)[index],
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
