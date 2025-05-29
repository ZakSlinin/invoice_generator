import 'package:auto_route/auto_route.dart';
import 'package:invoice_generator/features/get_started/screens/get_started_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: HomeRoute.page, initial: true),
  ];
}
