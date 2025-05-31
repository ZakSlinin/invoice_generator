part of 'your_items_bloc.dart';

abstract class YourItemsEvent {}

class YourItemsSaveEvent extends YourItemsEvent {
  final String email;
  final String phone;
  final String address;

  YourItemsSaveEvent({
    required this.email,
    required this.phone,
    required this.address,
  });
}
