import 'package:auto_route/auto_route.dart';

import 'pages/pages.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [AutoRoute(page: HomeRoute.page, path: '/')];
}
