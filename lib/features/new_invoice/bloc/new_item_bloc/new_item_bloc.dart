import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoice_generator/features/new_invoice/data/repositories/new_item_repositories/new_item_repository_impl.dart';

part 'new_item_event.dart';
part 'new_item_state.dart';

class NewItemBloc extends Bloc<NewItemEvent, NewItemState> {
  final NewItemRepositoryImpl _repository;
  List<Map<String, dynamic>> _currentSessionItems = [];

  NewItemBloc(this._repository) : super(NewItemInitial()) {
    on<NewItemSaveEvent>(_onSave);
    on<NewItemFetchEvent>(_onFetch);
  }

  Future<void> _onSave(
    NewItemSaveEvent event,
    Emitter<NewItemState> emit,
  ) async {
    try {
      await _repository.saveNewItemData(
        billTo: event.billTo,
        details: event.details,
        saveToItemsCatalog: event.saveToItemsCatalog,
        unitPrice: event.unitPrice,
        quantity: event.quantity,
        unitType: event.unitType,
        discount: event.discount,
        taxable: event.taxable,
        currency: event.currency,
      );

      // Refresh the items list to include the new item
      final items = await _repository.getAllItems();
      final newItem = items.firstWhere(
        (item) =>
            item['details'] == event.details &&
            item['unitPrice'] == event.unitPrice &&
            item['quantity'] == event.quantity,
        orElse: () => {},
      );

      if (newItem.isNotEmpty) {
        _currentSessionItems.add(newItem);
        emit(NewItemSaveSuccess(item: newItem));
      }

      emit(
        NewItemLoaded(items: items, currentSessionItems: _currentSessionItems),
      );
    } catch (e) {
      emit(NewItemSaveFailed(message: e.toString()));
    }
  }

  Future<void> _onFetch(
    NewItemFetchEvent event,
    Emitter<NewItemState> emit,
  ) async {
    try {
      final items = await _repository.getAllItems();
      emit(
        NewItemLoaded(items: items, currentSessionItems: _currentSessionItems),
      );
    } catch (e) {
      emit(NewItemLoadFailed(message: e.toString()));
    }
  }
}
