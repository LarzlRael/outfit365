part of '../pages.dart';

class MakeupPage extends StatelessWidget {
  static const String routeName = 'makeup_page';
  const MakeupPage({super.key});
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/makeup_creator');
        },
        child: Icon(Icons.add),
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            Image.network(
              'https://i.pinimg.com/736x/16/fe/ff/16feff6780cbea0374729540df7e0c88.jpg',
              fit: BoxFit.cover,
              height: double.infinity,
              /*  */
            ),
            Opacity(
              opacity: 0.5, // Valor de opacidad (0.0 a 1.0)
              child: Container(
                color: Colors.black, // Color oscuro
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).padding.top,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [],
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                height: 200,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Encuentra inspiración y crea looks increíbles',
                      style: textTheme.titleSmall!.copyWith(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    SimpleText(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      text:
                          'Descubre los mejores consejos y productos de maquillaje',
                      style: textTheme.titleSmall!.copyWith(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
