part of 'pages.dart';

class WelcomePage extends StatelessWidget {
  static const String routeName = 'welcome_page';

  const WelcomePage({super.key});
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProviderNotifier>(context);
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Stack(
            children: [
              Image.network(
                'https://wallpaperaccess.com/full/8280047.jpg',
                fit: BoxFit.cover,
                height: double.infinity,
                /*  */
              ),
              Opacity(
                opacity: 0.2, // Valor de opacidad (0.0 a 1.0)
                child: Container(
                  color: Colors.black, // Color oscuro
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).padding.top,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/icons/outfit365.png',
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                    SimpleText(
                      text: appName.toUpperCase(),
                      style: textTheme.titleSmall!.copyWith(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 20),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Renueva y redefine tu estilo',
                        style: textTheme.titleSmall!.copyWith(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SimpleText(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        text:
                            'Cambiemos el estilo de tu apariencia con Outfit 365',
                        style: textTheme.titleSmall!.copyWith(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 65,
                        child: FilledButton(
                          onPressed: () {
                            context.push('/');
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Empezar',
                                style: textTheme.titleSmall!.copyWith(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Transform.rotate(
                                angle: 315 * math.pi / 180,
                                child: Icon(
                                  Icons.arrow_forward,
                                  size: 20,
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
