abstract class YourItemsRepository {
  Future<void> saveYourItemsData({
    String? email,
    String? phone,
    required String address,
  });

  Future<Map<String, String?>> getYourItemsData();
}
