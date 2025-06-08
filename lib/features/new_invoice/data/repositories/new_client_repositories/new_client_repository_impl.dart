import 'package:invoice_generator/features/new_invoice/data/repositories/new_client_repositories/abstract_new_client_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewClientRepositoryImpl implements NewClientRepository {
  static const String _clientsKey = 'clients';

  @override
  Future<void> saveNewClientData({
    String? email,
    String? phone,
    required String address,
    required String billTo,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    final clientsList = prefs.getStringList(_clientsKey) ?? [];

    final clientId = DateTime.now().millisecondsSinceEpoch.toString();

    await prefs.setString('client_${clientId}_email', email ?? '');
    await prefs.setString('client_${clientId}_phone', phone ?? '');
    await prefs.setString('client_${clientId}_address', address);
    await prefs.setString('client_${clientId}_billTo', billTo);

    clientsList.add(clientId);
    await prefs.setStringList(_clientsKey, clientsList);
  }

  @override
  Future<Map<String, String?>> getNewClientData() async {
    final prefs = await SharedPreferences.getInstance();
    final clientsList = prefs.getStringList(_clientsKey) ?? [];

    if (clientsList.isEmpty) {
      return {'email': null, 'phone': null, 'address': null, 'billTo': null};
    }

    final lastClientId = clientsList.last;

    return {
      'email': prefs.getString('client_${lastClientId}_email'),
      'phone': prefs.getString('client_${lastClientId}_phone'),
      'address': prefs.getString('client_${lastClientId}_address'),
      'billTo': prefs.getString('client_${lastClientId}_billTo'),
    };
  }

  Future<List<Map<String, String?>>> getAllClients() async {
    final prefs = await SharedPreferences.getInstance();
    final clientsList = prefs.getStringList(_clientsKey) ?? [];

    return clientsList.map((clientId) {
      return {
        'id': clientId,
        'email': prefs.getString('client_${clientId}_email'),
        'phone': prefs.getString('client_${clientId}_phone'),
        'address': prefs.getString('client_${clientId}_address'),
        'billTo': prefs.getString('client_${clientId}_billTo'),
      };
    }).toList();
  }

  Future<Map<String, String?>> getClientById(String clientId) async {
    final prefs = await SharedPreferences.getInstance();

    return {
      'id': clientId,
      'email': prefs.getString('client_${clientId}_email'),
      'phone': prefs.getString('client_${clientId}_phone'),
      'address': prefs.getString('client_${clientId}_address'),
      'billTo': prefs.getString('client_${clientId}_billTo'),
    };
  }
}
