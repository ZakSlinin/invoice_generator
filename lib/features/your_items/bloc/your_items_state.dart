part of 'your_items_bloc.dart';

abstract class YourItemsState {}

class YourItemsInitial extends YourItemsState {}

class YourItemsSaveSuccess extends YourItemsState {}

class YourItemsSaveFailed extends YourItemsState {
  final String message;

  YourItemsSaveFailed({required this.message});
}
