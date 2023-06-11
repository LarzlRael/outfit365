part of 'pages.dart';

class MakeupCreator extends StatelessWidget {
  static const String routeName = 'makeup_creator';
  const MakeupCreator({super.key});
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Maquillaje'),
          bottom: TabBar(
            isScrollable: true,
            indicator: null,
            indicatorColor: Colors.transparent,
            labelColor: Colors.black,
            labelStyle: textTheme.titleSmall!.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
            unselectedLabelStyle: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 14,
            ),
            unselectedLabelColor: Colors.black,
            tabs: [
              Tab(text: 'All'),
              Tab(text: 'Skincare'),
              Tab(text: 'Make-up'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Contenido de la pestaña 1
            Container(
              color: Colors.red,
            ),
            // Contenido de la pestaña 2
            Container(
              color: Colors.green,
            ),
            // Contenido de la pestaña 3
            Container(
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}
