import 'package:shared_preferences/shared_preferences.dart';
import 'abstract_your_items_repository.dart';

class YourItemsRepositoryImpl implements YourItemsRepository {
  @override
  Future<void> saveYourItemsData({
    String? email,
    String? phone,
    required String address,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    if (email != null) {
      await prefs.setString('email', email);
    }

    if (phone != null) {
      await prefs.setString('phone', phone);
    }

    await prefs.setString('address', address);
  }

  @override
  Future<Map<String, String?>> getYourItemsData() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'email': prefs.getString('email'),
      'phone': prefs.getString('phone'),
      'address': prefs.getString('address'),
    };
  }
}
