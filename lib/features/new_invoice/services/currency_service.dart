
import 'package:shared_preferences/shared_preferences.dart';

class CurrencyService {
  static const String _selectedCurrencyKey = 'selected_currency';
  static const String _recentCurrenciesKey = 'recent_currencies';
  static const int _maxRecentCurrencies = 3;

  static Future<String> getSelectedCurrency() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_selectedCurrencyKey) ?? 'USD';
  }

  static Future<void> setSelectedCurrency(String currencyCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_selectedCurrencyKey, currencyCode);
    await _updateRecentCurrencies(currencyCode);
  }

  static Future<List<String>> getRecentCurrencies() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_recentCurrenciesKey) ?? ['USD', 'EUR', 'GBP'];
  }

  static Future<void> _updateRecentCurrencies(String currencyCode) async {
    final prefs = await SharedPreferences.getInstance();
    final recent = prefs.getStringList(_recentCurrenciesKey) ?? [];

    recent.remove(currencyCode);

    recent.insert(0, currencyCode);

    if (recent.length > _maxRecentCurrencies) {
      recent.removeLast();
    }

    await prefs.setStringList(_recentCurrenciesKey, recent);
  }
}
