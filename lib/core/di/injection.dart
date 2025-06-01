import 'package:get_it/get_it.dart';
import 'package:invoice_generator/features/your_items/bloc/your_items_bloc.dart';
import 'package:invoice_generator/features/your_items/data/repositories/abstract_your_items_repository.dart';
import 'package:invoice_generator/features/your_items/data/repositories/your_items_repository_impl.dart';

final getIt = GetIt.I;

void setupDependencies() {
  getIt.registerSingleton<YourItemsRepositoryImpl>(YourItemsRepositoryImpl());
  getIt.registerSingleton<YourItemsBloc>(YourItemsBloc(getIt<YourItemsRepositoryImpl>()));
}