part of 'new_client_bloc.dart';

class NewClientState {}

class NewClientInitial extends NewClientState {}

class NewClientSaveSuccess extends NewClientState {}

class NewClientSaveFailed extends NewClientState {
  final String message;

  NewClientSaveFailed({required this.message});
}