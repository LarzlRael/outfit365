part of 'pages.dart';

class MakeupCreator extends StatelessWidget {
  static const String routeName = 'makeup_creator';
  const MakeupCreator({super.key});
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return DefaultTabController(
      length: 4,
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
              Tab(text: 'Todos'),
              Tab(text: 'Maquillaje facial'),
              Tab(text: 'Maquillaje de ojos'),
              Tab(text: 'Herramientas y accesorios de maquillaje'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Contenido de la pestaña 1
            VideoScrollabelView(),
            VideoScrollabelView(),
            VideoScrollabelView(),
            VideoScrollabelView(),
          ],
        ),
      ),
    );
  }
}
