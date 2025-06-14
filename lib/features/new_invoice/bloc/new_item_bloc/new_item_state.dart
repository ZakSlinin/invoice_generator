part of 'new_item_bloc.dart';

abstract class NewItemState {}

class NewItemInitial extends NewItemState {}

class NewItemSaveSuccess extends NewItemState {
  final Map<String, dynamic> item;

  NewItemSaveSuccess({required this.item});
}

class NewItemSaveFailed extends NewItemState {
  final String message;

  NewItemSaveFailed({required this.message});
}

class NewItemLoaded extends NewItemState {
  final List<Map<String, dynamic>> items;
  final List<Map<String, dynamic>> currentSessionItems;

  NewItemLoaded({required this.items, this.currentSessionItems = const []});
}

class NewItemLoadFailed extends NewItemState {
  final String message;

  NewItemLoadFailed({required this.message});
}
