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
              tabItem("Outfits"),
              tabItem("Maquillaje"),
              tabItem("Ropa y maquillaje"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  context.push('/pick_outfit');
                },
                child: Icon(Icons.add),
              ),
              body: Container(
                padding: const EdgeInsets.all(15.0),
                width: double.infinity,
                child: AlignedGridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 25,
                  itemCount: registerOptions(context).length,
                  itemBuilder: (context, index) =>
                      registerOptions(context)[index],
                ),
              ),
            ),
            MakeupPage(),
            Center(
                child: TextButton(
              onPressed: () {
                context.push('/find_map');
              },
              child: Text('Ir a la pagina'),
            )),
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
