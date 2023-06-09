part of 'pages.dart';

class HomePage extends StatelessWidget {
  final List<String> cloths = [
    "assets/animated.glb",
    "assets/punk_girl.glb",
    "assets/animated_woman2.glb",
    "assets/t-shirt.glb",
  ];

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cloths.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(cloths[index]),
                    onTap: () {
                      context.push('/model', extra: cloths[index]);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
