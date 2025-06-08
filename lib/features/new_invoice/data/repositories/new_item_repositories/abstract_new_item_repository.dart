abstract class NewItemRepository {
  Future<void> saveNewItemData({
    required String billTo,
    required String details,
    required bool saveToItemsCatalog,
    required String unitPrice,
    required String quantity,
    required String unitType,
    required bool discount,
    required String taxable,
  });
}
