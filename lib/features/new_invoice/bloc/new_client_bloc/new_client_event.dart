part of 'new_client_bloc.dart';

class NewClientEvent {}

class NewClientSaveEvent extends NewClientEvent {
  final String email;
  final String phone;
  final String address;

  NewClientSaveEvent({
    required this.email,
    required this.phone,
    required this.address,
  });
}
