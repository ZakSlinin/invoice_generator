part of 'new_client_bloc.dart';

abstract class NewClientState {}

class NewClientInitial extends NewClientState {}

class NewClientSaveSuccess extends NewClientState {
  final Map<String, dynamic> client;

  NewClientSaveSuccess({required this.client});
}

class NewClientSaveFailed extends NewClientState {
  final String message;

  NewClientSaveFailed({required this.message});
}

class NewClientLoaded extends NewClientState {
  final List<Map<String, dynamic>> clients;
  final List<Map<String, dynamic>> currentSessionClients;

  NewClientLoaded({
    required this.clients,
    this.currentSessionClients = const [],
  });
}

class NewClientLoadFailed extends NewClientState {
  final String message;

  NewClientLoadFailed({required this.message});
}
