import 'package:flutter/material.dart';
import 'package:invoice_generator/core/theme/theme.dart';

import '../router/app_router.dart';

class InvoiceGeneratorApp extends StatelessWidget {
  InvoiceGeneratorApp({super.key});

  final _appRouter = AppRouter();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: lightTheme,
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
    );
  }
}
