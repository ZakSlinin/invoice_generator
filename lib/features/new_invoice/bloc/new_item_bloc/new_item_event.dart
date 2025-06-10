part of 'new_item_bloc.dart';

abstract class NewItemEvent {}

class NewItemSaveEvent extends NewItemEvent {
  final String billTo;
  final String details;
  final bool saveToItemsCatalog;
  final String unitPrice;
  final String quantity;
  final String unitType;
  final bool discount;
  final String taxable;

  NewItemSaveEvent({
    required this.billTo,
    required this.details,
    required this.saveToItemsCatalog,
    required this.unitPrice,
    required this.quantity,
    required this.unitType,
    required this.discount,
    required this.taxable,
  });
}
