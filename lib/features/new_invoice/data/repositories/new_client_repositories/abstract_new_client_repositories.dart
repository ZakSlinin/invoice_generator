abstract class NewClientRepository {
  Future<void> saveNewClientData({
    String? email,
    String? phone,
    required String address,
});

  Future<Map<String, String?>> getNewClientData();
}