part of '../pages.dart';

class MapPresentation extends StatelessWidget {
  const MapPresentation({super.key});
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SizedBox.expand(
        child: Stack(
          children: [
            Image.network(
              'https://as2.ftcdn.net/v2/jpg/05/74/14/89/1000_F_574148918_KLJ8AzYtawdUoXgPjX7k1ffEo9sZQN1V.jpg',
              fit: BoxFit.fill,
              height: double.infinity,
              /* width: double.infinity, */
            ),
            Opacity(
              opacity: 0.3, // Valor de opacidad (0.0 a 1.0)
              child: Container(
                color: Colors.black, // Color oscuro
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                height: 250,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Encuentra las mejores tiendas de ropa y maquillaje',
                      style: textTheme.titleSmall!.copyWith(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    SimpleText(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      text:
                          'Encuentra moda y maquillaje al alcance de tu mano con nuestro mapa buscador',
                      style: textTheme.titleSmall!.copyWith(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                        width: 150,
                        height: 50,
                        child: ButtonIcon(
                          textButton: 'Ir al mapa',
                          icon: Icons.arrow_forward,
                          rotation: 315,
                          onPressed: () {
                            context.push('/find_map');
                          },
                        ),
                      ),
                    )
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
