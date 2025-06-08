abstract class NewClientRepository {
  Future<void> saveNewClientData({
    String? email,
    String? phone,
    required String address,
    required String billTo,
  });

  Future<Map<String, String?>> getNewClientData();
}
