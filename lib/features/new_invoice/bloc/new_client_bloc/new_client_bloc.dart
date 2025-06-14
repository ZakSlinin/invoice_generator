import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoice_generator/core/di/injection.dart';
import 'package:invoice_generator/features/new_invoice/data/repositories/new_client_repositories/new_client_repository_impl.dart';

part 'new_client_event.dart';
part 'new_client_state.dart';

class NewClientBloc extends Bloc<NewClientEvent, NewClientState> {
  final NewClientRepositoryImpl _repository;
  List<Map<String, dynamic>> _currentSessionClients = [];

  NewClientBloc(this._repository) : super(NewClientInitial()) {
    on<NewClientSaveEvent>(_onSave);
    on<NewClientFetchEvent>(_onFetch);
  }

  Future<void> _onSave(
    NewClientSaveEvent event,
    Emitter<NewClientState> emit,
  ) async {
    try {
      final clientId = DateTime.now().millisecondsSinceEpoch.toString();
      await _repository.saveNewClientData(
        email: event.email,
        phone: event.phone,
        address: event.address,
        billTo: event.billTo,
      );

      // Refresh the clients list to include the new client
      final clients = await _repository.getAllClients();
      _currentSessionClients
        ..clear()
        ..addAll(clients);

      final client = _currentSessionClients.firstWhere(
        (c) =>
            c['billTo'] == event.billTo &&
            c['email'] == event.email &&
            c['phone'] == event.phone &&
            c['address'] == event.address,
        orElse: () => {},
      );

      if (client.isNotEmpty) {
        emit(NewClientSaveSuccess(client: client));
      }

      emit(
        NewClientLoaded(
          clients: clients,
          currentSessionClients: _currentSessionClients,
        ),
      );
    } catch (e) {
      emit(NewClientSaveFailed(message: e.toString()));
    }
  }

  Future<void> _onFetch(
    NewClientFetchEvent event,
    Emitter<NewClientState> emit,
  ) async {
    try {
      final clients = await _repository.getAllClients();
      _currentSessionClients
        ..clear()
        ..addAll(clients);
      emit(
        NewClientLoaded(
          clients: clients,
          currentSessionClients: _currentSessionClients,
        ),
      );
    } catch (e) {
      emit(NewClientLoadFailed(message: e.toString()));
    }
  }
}
