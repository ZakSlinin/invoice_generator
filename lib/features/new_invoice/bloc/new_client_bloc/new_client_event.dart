part of 'new_client_bloc.dart';

abstract class NewClientEvent {}

class NewClientSaveEvent extends NewClientEvent {
  final String? email;
  final String? phone;
  final String address;
  final String billTo;

  NewClientSaveEvent({
    this.email,
    this.phone,
    required this.address,
    required this.billTo,
  });
}

class NewClientFetchEvent extends NewClientEvent {}
