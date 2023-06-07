import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:outfilt/router/app_router.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
    );
  }
}

class MainPage extends StatelessWidget {
  final List<String> cloths = [
    "assets/animated.glb",
    "assets/punk_girl.glb",
    "assets/animated_woman2.glb",
    "assets/t-shirt.glb",
  ];

  MainPage({super.key});

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
