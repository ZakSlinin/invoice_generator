part of 'new_item_bloc.dart';

abstract class NewItemState {}

class NewItemInitial extends NewItemState {}

class NewItemSaveSuccess extends NewItemState {}

class NewItemSaveFailed extends NewItemState {
  final String message;

  NewItemSaveFailed({required this.message});
}
