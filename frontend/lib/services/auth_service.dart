import 'package:adjo/mock-data/mock-data.dart';
import 'package:adjo/models/user.dart';

class AuthService {
  User? _currentUser;
  final Map<String, String> _verificationCodes = {};

  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  Future<User> login(String phone, String password) async {
    await MockData.simulateDelay(1200);

    if (password.length < 8) {
      throw Exception('Invalid credentials');
    }

    _currentUser = MockData.demoUser;
    return _currentUser!;
  }

  Future<User> signup({
    required String name,
    required String phone,
    required String password,
  }) async {
    await MockData.simulateDelay(1500);

    _currentUser = User(
      id: 'user_${DateTime.now().millisecondsSinceEpoch}',
      name: name,
      email: '$phone@adjo.app',
      phone: phone,
      walletAddress: 'G${_generateRandomString(50)}',
      subscription: 'free',
      isVerified: false,
      createdAt: DateTime.now(),
    );

    return _currentUser!;
  }

  Future<void> logout() async {
    await MockData.simulateDelay(300);
    _currentUser = null;
  }

  User? getCurrentUser() => _currentUser;

  Future<void> sendPasswordResetCode(String phone) async {
    await MockData.simulateDelay(800);
    _verificationCodes[phone] = '12345';
  }

  Future<bool> verifyResetCode(String phone, String code) async {
    await MockData.simulateDelay(500);
    return _verificationCodes[phone] == code;
  }

  Future<void> resetPassword(String phone, String newPassword) async {
    await MockData.simulateDelay(600);
  }

  String _generateRandomString(int length) {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    return List.generate(length, (i) => chars[(i * 7) % chars.length]).join();
  }
}
