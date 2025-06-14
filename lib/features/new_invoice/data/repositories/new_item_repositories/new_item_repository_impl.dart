import 'package:invoice_generator/features/new_invoice/data/repositories/new_item_repositories/abstract_new_item_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewItemRepositoryImpl implements NewItemRepository {
  static const String _itemsKey = 'items';

  @override
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
  }) async {
    final prefs = await SharedPreferences.getInstance();

    final itemsList = prefs.getStringList(_itemsKey) ?? [];

    final itemId = DateTime.now().millisecondsSinceEpoch.toString();

    await prefs.setString('item_${itemId}_billTo', billTo);
    await prefs.setString('item_${itemId}_details', details);
    await prefs.setBool('item_${itemId}_saveToCatalog', saveToItemsCatalog);
    await prefs.setDouble('item_${itemId}_unitPrice', unitPrice);
    await prefs.setDouble('item_${itemId}_quantity', quantity);
    await prefs.setString('item_${itemId}_unitType', unitType);
    await prefs.setBool('item_${itemId}_discount', discount);
    await prefs.setString('item_${itemId}_taxable', taxable);
    await prefs.setString('item_${itemId}_currency', currency);

    itemsList.add(itemId);
    await prefs.setStringList(_itemsKey, itemsList);
  }

  Future<List<Map<String, dynamic>>> getAllItems() async {
    final prefs = await SharedPreferences.getInstance();
    final itemsList = prefs.getStringList(_itemsKey) ?? [];

    return itemsList.map((itemId) {
      final unitPriceDynamic = prefs.get('item_${itemId}_unitPrice');
      double unitPrice = 0.0;
      if (unitPriceDynamic is double) {
        unitPrice = unitPriceDynamic;
      } else if (unitPriceDynamic is String) {
        unitPrice = double.tryParse(unitPriceDynamic) ?? 0.0;
      }

      final quantityDynamic = prefs.get('item_${itemId}_quantity');
      double quantity = 0.0;
      if (quantityDynamic is double) {
        quantity = quantityDynamic;
      } else if (quantityDynamic is String) {
        quantity = double.tryParse(quantityDynamic) ?? 0.0;
      }

      return {
        'id': itemId,
        'billTo': prefs.getString('item_${itemId}_billTo'),
        'details': prefs.getString('item_${itemId}_details'),
        'saveToCatalog': prefs.getBool('item_${itemId}_saveToCatalog'),
        'unitPrice': unitPrice,
        'quantity': quantity,
        'unitType': prefs.getString('item_${itemId}_unitType'),
        'discount': prefs.getBool('item_${itemId}_discount'),
        'taxable': prefs.getString('item_${itemId}_taxable'),
        'currency': prefs.getString('item_${itemId}_currency'),
      };
    }).toList();
  }

  Future<Map<String, dynamic>> getItemById(String itemId) async {
    final prefs = await SharedPreferences.getInstance();

    final unitPriceDynamic = prefs.get('item_${itemId}_unitPrice');
    double unitPrice = 0.0;
    if (unitPriceDynamic is double) {
      unitPrice = unitPriceDynamic;
    } else if (unitPriceDynamic is String) {
      unitPrice = double.tryParse(unitPriceDynamic) ?? 0.0;
    }

    final quantityDynamic = prefs.get('item_${itemId}_quantity');
    double quantity = 0.0;
    if (quantityDynamic is double) {
      quantity = quantityDynamic;
    } else if (quantityDynamic is String) {
      quantity = double.tryParse(quantityDynamic) ?? 0.0;
    }

    return {
      'id': itemId,
      'billTo': prefs.getString('item_${itemId}_billTo'),
      'details': prefs.getString('item_${itemId}_details'),
      'saveToCatalog': prefs.getBool('item_${itemId}_saveToCatalog'),
      'unitPrice': unitPrice,
      'quantity': quantity,
      'unitType': prefs.getString('item_${itemId}_unitType'),
      'discount': prefs.getBool('item_${itemId}_discount'),
      'taxable': prefs.getString('item_${itemId}_taxable'),
      'currency': prefs.getString('item_${itemId}_currency'),
    };
  }
}
