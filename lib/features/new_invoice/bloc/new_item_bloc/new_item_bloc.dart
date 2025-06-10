import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoice_generator/features/new_invoice/data/repositories/new_item_repositories/new_item_repository_impl.dart';

part 'new_item_event.dart';
part 'new_item_state.dart';

class NewItemBloc extends Bloc<NewItemEvent, NewItemState> {
  final NewItemRepositoryImpl _repository;

  NewItemBloc(this._repository) : super(NewItemInitial()) {
    on<NewItemSaveEvent>(_onSave);
  }

  Future<void> _onSave(
    NewItemSaveEvent event,
    Emitter<NewItemState> emit,
  ) async {
    try {
      print('Bill To: ${event.billTo}');
      print('Details: ${event.details}');
      print('Save to Catalog: ${event.saveToItemsCatalog}');
      print('Unit Price: ${event.unitPrice}');
      print('Quantity: ${event.quantity}');
      print('Unit Type: ${event.unitType}');
      print('Discount: ${event.discount}');
      print('Taxable: ${event.taxable}');

      await _repository.saveNewItemData(
        billTo: event.billTo,
        details: event.details,
        saveToItemsCatalog: event.saveToItemsCatalog,
        unitPrice: event.unitPrice,
        quantity: event.quantity,
        unitType: event.unitType,
        discount: event.discount,
        taxable: event.taxable,
      );

      emit(NewItemSaveSuccess());
    } catch (e) {
      emit(NewItemSaveFailed(message: e.toString()));
    }
  }
}
