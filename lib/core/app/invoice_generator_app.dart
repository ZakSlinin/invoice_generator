import 'package:flutter/material.dart';
import 'package:invoice_generator/core/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../router/app_router.dart';

class InvoiceGeneratorApp extends StatelessWidget {
  final AppRouter appRouter;
  final bool completedOnboarding;

  InvoiceGeneratorApp({
    required this.appRouter,
    required this.completedOnboarding,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: lightTheme,
      routerDelegate: appRouter.delegate(),
      routeInformationParser: appRouter.defaultRouteParser(),
      builder: (context, router) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (completedOnboarding) {
            appRouter.replace(const DashboardRoute()); //TODO: refactor to Dashboard
          } else {
            appRouter.replace(const GetStartedRoute());
          }
        });

        return router!;
      },
    );
  }
}
