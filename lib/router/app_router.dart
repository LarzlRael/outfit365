import 'package:go_router/go_router.dart';
import '../pages/pages.dart';

final appRouter = GoRouter(
  initialLocation: '/welcome',
  /* refreshListenable: goRouterNotifier, */
  routes: [
    ///* Primera pantalla
    GoRoute(
      path: '/',
      builder: (context, state) => HomePage(),
    ),
    GoRoute(
      path: '/welcome',
      builder: (context, state) => WelcomePage(),
    ),
    GoRoute(
      path: '/modelviewer',
      builder: (context, state) {
        return ModelViewPage();
      },
    ),
    GoRoute(
      path: '/pick_outfit',
      builder: (context, state) => PickOutfitPage(),
    ),
    GoRoute(
      path: '/makeup_creator',
      builder: (context, state) => MakeupCreator(),
    ),
  ],
);
