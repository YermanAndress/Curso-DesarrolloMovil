import 'package:go_router/go_router.dart';

import 'package:taller_datos_abiertos/views/dashboard_screen.dart';
import 'package:taller_datos_abiertos/views/list_screen.dart';
import 'package:taller_datos_abiertos/views/detail_screen.dart';

class AppRouter {
  static const String dashboard = '/';
  static const String list = '/list';
  static const String detail = '/detail';

  static final GoRouter router = GoRouter(
    initialLocation: dashboard,
    routes: [
      GoRoute(
        name: 'dashboard',
        path: dashboard,
        builder: (context, state) => const DashboardScreen(),
      ),
      GoRoute(
        name: 'list',
        path: list,
        builder: (context, state) {
          final endpoint = state.uri.queryParameters['endpoint'] ?? '';
          final title = state.uri.queryParameters['title'] ?? '';
          return ListScreen(endpoint: endpoint, title: title);
        },
      ),
      GoRoute(
        name: 'detail',
        path: detail,
        builder: (context, state) {
          final endpoint = state.uri.queryParameters['endpoint'] ?? '';
          final id = int.tryParse(state.uri.queryParameters['id'] ?? '0') ?? 0;
          return DetailScreen(endpoint: endpoint, id: id);
        },
      ),
    ],
  );
}
