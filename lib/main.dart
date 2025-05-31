import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoice_generator/core/app/invoice_generator_app.dart';
import 'package:invoice_generator/core/di/injection.dart';
import 'package:invoice_generator/features/your_items/bloc/your_items_bloc.dart';
import 'package:invoice_generator/features/your_items/data/repositories/your_items_repository_impl.dart';

void main() {
  setupDependencies();
  runApp(
    MultiBlocProvider(
      child: InvoiceGeneratorApp(),
      providers: [
        BlocProvider(
          create: (context) => YourItemsBloc(getIt<YourItemsRepositoryImpl>()),
        ),
      ],
    ),
  );
}

class InvoiceHomeScreen extends StatelessWidget {
  const InvoiceHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
