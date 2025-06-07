import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoice_generator/core/di/injection.dart';
import 'package:invoice_generator/features/new_invoice/data/repositories/new_client_repositories/new_client_repository_impl.dart';

part 'new_client_event.dart';
part 'new_client_state.dart';

class NewClientBloc extends Bloc<NewClientEvent, NewClientState> {
  final NewClientRepositoryImpl _repository;
  NewClientBloc(this._repository) : super(NewClientInitial()) {
    on<NewClientSaveEvent>(_onSave);
  }

  Future<void> _onSave(
      NewClientSaveEvent event,
      Emitter<NewClientState> emit,
      ) async {
    try {
      print('Email: ${event.email}');
      print('Address: ${event.address}');
      print('Phone: ${event.phone}');

      await _repository.saveNewClientData(
        email: event.email,
        phone: event.phone,
        address: event.address,
      );


      emit(NewClientSaveSuccess());
    } catch (e) {
      emit(NewClientSaveFailed(message: e.toString()));
    }
  }
}
