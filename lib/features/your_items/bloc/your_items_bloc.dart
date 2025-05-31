import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoice_generator/core/di/injection.dart';
import 'package:invoice_generator/features/your_items/data/repositories/your_items_repository_impl.dart';

part 'your_items_event.dart';
part 'your_items_state.dart';

class YourItemsBloc extends Bloc<YourItemsEvent, YourItemsState> {
  final YourItemsRepositoryImpl _repository;

  YourItemsBloc(this._repository) : super(YourItemsInitial()) {
    on<YourItemsSaveEvent>(_onSave);
  }

  Future<void> _onSave(
    YourItemsSaveEvent event,
    Emitter<YourItemsState> emit,
  ) async {
    try {
      print('Email: ${event.email}');
      print('Avatar file: ${event.address}');
      print('Header file: ${event.phone}');

      await _repository.saveYourItemsData(
        email: event.email,
        phone: event.phone,
        address: event.address,
      );
      emit(YourItemsSaveSuccess());
    } catch (e) {
      emit(YourItemsSaveFailed(message: e.toString()));
    }
  }
}
