import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:harmonia/app/dependencies.dart';
import 'package:harmonia/auth/domain/repositories/auth_repository.dart';
import 'package:harmonia/ui/auth/pages/forgot_password_page.dart';
import 'package:harmonia/ui/auth/pages/login_page.dart';
import 'package:harmonia/ui/auth/pages/register_page.dart';
import 'package:harmonia/ui/player/pages/app_page.dart';

import 'routes.dart';

GoRouter nav = router(injector.get<AuthRepository>());

/// Top go_router entry point.
///
/// Listens to changes in [AuthTokenRepository] to redirect the user
/// to /login when the user logs out.
GoRouter router(
  AuthRepository authRepository,
) =>
    GoRouter(
      initialLocation: Routes.home,
      debugLogDiagnostics: true,
      redirect: _redirect,
      refreshListenable: authRepository,
      routes: [
        GoRoute(
          path: Routes.home,
          builder: (context, state) => const AppPage(page: 1),
        ),
        GoRoute(
          path: Routes.player,
          builder: (context, state) {
            final page = int.tryParse(state.pathParameters['page']!) ?? 1;
            return AppPage(page: page);
          },
        ),
        GoRoute(
          path: Routes.login,
          builder: (context, state) => const LoginPage(),
          routes: [
            GoRoute(
              path: Routes.forgotPassword,
              builder: (context, state) => const ForgotPasswordPage(),
            ),
            GoRoute(
              path: Routes.register,
              builder: (context, state) => const RegisterPage(),
            )
          ],
        ),
        GoRoute(
          path: Routes.logout,
          builder: (context, state) => const LoginPage(),
        ),
      ],
    );

// From https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/redirection.dart
Future<String?> _redirect(BuildContext context, GoRouterState state) async {
  // if the user is not logged in, they need to login
  final loggedIn = await injector.get<AuthRepository>().isAuthenticated;
  final freeRoutes = [Routes.register, Routes.forgotPassword];
  final isLoginRoute = state.matchedLocation == Routes.login;

  // if the route is free, no need to redirect
  final isFreeRoute = freeRoutes
      .where((route) => route.endsWith(state.matchedLocation))
      .isEmpty;

  if (isFreeRoute) {
    return null;
  }

  if (!loggedIn) {
    return isLoginRoute ? null : Routes.login;
  }

  // if the user is logged in but still on the login page, send them to
  // the home page
  if (isLoginRoute) return Routes.home;

  // no need to redirect at all
  return null;
}
