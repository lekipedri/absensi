class AuthService {
  static final List<Map<String, String>> _users = [
    {"email": "admin", "password": "123", "name": "Admin Kantor"},
  ];

  static Future<Map<String, String>?> login(
      String email, String password) async {
    await Future.delayed(Duration(seconds: 1));

    for (var user in _users) {
      if (user['email'] == email && user['password'] == password) {
        return user;
      }
    }

    return null;
  }
}
