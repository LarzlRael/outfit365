import 'package:flutter/material.dart';
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
    GoRoute(
        path: '/find_map',
        /* builder: (context, state) => MapSample(), */
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            transitionDuration: Duration(milliseconds: 1000),
            reverseTransitionDuration: Duration(milliseconds: 1000),
            child: MapSample(),
            transitionsBuilder: (
              context,
              animation,
              secondaryAnimation,
              child,
            ) {
              return ScaleTransition(
                scale: animation,
                child: child,
              );
            },
          );
        }),
    GoRoute(
      path: '/show_details_page',
      /* builder: (context, state) {
        QueryAndTitle queryToSearch = state.extra as QueryAndTitle;
        return ShowDetailsPage(
          queryToSearch: queryToSearch,
        );
      }, */
      pageBuilder: (context, state) {
        QueryAndTitle queryToSearch = state.extra as QueryAndTitle;
        return CustomTransitionPage(
          transitionDuration: Duration(milliseconds: 500),
          reverseTransitionDuration: Duration(milliseconds: 500),
          child: ShowDetailsPage(
            queryToSearch: queryToSearch,
          ),
          transitionsBuilder: (
            context,
            animation,
            secondaryAnimation,
            child,
          ) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        );
      },
    ),

    GoRoute(
      path: '/animations',
      builder: (context, state) => AnimationSquare(),
    ),
  ],
);
