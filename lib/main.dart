import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoice_generator/core/app/invoice_generator_app.dart';
import 'package:invoice_generator/core/di/injection.dart';
import 'package:invoice_generator/features/your_items/bloc/your_items_bloc.dart';
import 'package:invoice_generator/features/your_items/data/repositories/your_items_repository_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/router/app_router.dart';

void main() async {
  setupDependencies();
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final bool completedOnboarding = prefs.getBool('first_login') ?? false;

  final appRouter = AppRouter();
  runApp(
    MultiBlocProvider(
      child: InvoiceGeneratorApp(
        appRouter: appRouter,
        completedOnboarding: completedOnboarding,
      ),
      providers: [
        BlocProvider(
          create: (context) => YourItemsBloc(getIt<YourItemsRepositoryImpl>()),
        ),
      ],
    ),
  );
}
