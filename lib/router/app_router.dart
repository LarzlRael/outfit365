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
        path: '/model',
        builder: (context, state) {
          final String cloth = state.extra as String;
          return ModelViewPage(cloth: cloth);
        },
      ),
    ]);
