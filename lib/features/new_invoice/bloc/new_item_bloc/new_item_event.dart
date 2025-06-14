part of 'new_item_bloc.dart';

abstract class NewItemEvent {}

class NewItemSaveEvent extends NewItemEvent {
  final String billTo;
  final String details;
  final bool saveToItemsCatalog;
  final double unitPrice;
  final double quantity;
  final String unitType;
  final bool discount;
  final String taxable;
  final String currency;

  NewItemSaveEvent({
    required this.billTo,
    required this.details,
    required this.saveToItemsCatalog,
    required this.unitPrice,
    required this.quantity,
    required this.unitType,
    required this.discount,
    required this.taxable,
    required this.currency,
  });
}

class NewItemFetchEvent extends NewItemEvent {}
