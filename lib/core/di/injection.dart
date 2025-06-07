import 'package:get_it/get_it.dart';
import 'package:invoice_generator/features/new_invoice/bloc/new_client_bloc/new_client_bloc.dart';
import 'package:invoice_generator/features/new_invoice/data/repositories/new_client_repositories/abstract_new_client_repositories.dart';
import 'package:invoice_generator/features/new_invoice/data/repositories/new_client_repositories/new_client_repository_impl.dart';
import 'package:invoice_generator/features/your_items/bloc/your_items_bloc.dart';
import 'package:invoice_generator/features/your_items/data/repositories/your_items_repository_impl.dart';

final getIt = GetIt.I;

void setupDependencies() {
  getIt.registerSingleton<YourItemsRepositoryImpl>(YourItemsRepositoryImpl());
  getIt.registerSingleton<YourItemsBloc>(YourItemsBloc(getIt<YourItemsRepositoryImpl>()));
  getIt.registerSingleton<NewClientRepositoryImpl>(NewClientRepositoryImpl());
  getIt.registerSingleton<NewClientBloc>(NewClientBloc(getIt<NewClientRepositoryImpl>()));
}