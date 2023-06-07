import 'package:go_router/go_router.dart';

import '../main.dart';
import '../pages/model_view_page.dart';

final appRouter = GoRouter(
    initialLocation: '/',
    /* refreshListenable: goRouterNotifier, */
    routes: [
      ///* Primera pantalla
      GoRoute(
        path: '/',
        builder: (context, state) => MainPage(),
      ),
      GoRoute(
        path: '/model',
        builder: (context, state) {
          final String cloth = state.extra as String;
          return ModelViewPage(cloth: cloth);
        },
      ),
    ]);
