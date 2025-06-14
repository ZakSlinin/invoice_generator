abstract class NewItemRepository {
  Future<void> saveNewItemData({
    required String billTo,
    required String details,
    required bool saveToItemsCatalog,
    required double unitPrice,
    required double quantity,
    required String unitType,
    required bool discount,
    required String taxable,
    required String currency,
  });
}
