import 'package:adjo/mock-data/mock-data.dart';
import 'package:adjo/models/user.dart';
import 'package:adjo/services/storage_service.dart';

class AuthService {
  User? _currentUser;
  final Map<String, String> _verificationCodes = {};

  // Mock database with multiple test users
  final Map<String, Map<String, String>> _mockUsers = {
    '0161762591': {'password': 'Karim&1234', 'name': 'Karim Diallo'},
    '0165432109': {'password': 'Test&1234', 'name': 'Test User'},
    '0123456789': {'password': 'Demo&1234', 'name': 'Demo Account'},
  };

  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  Future<User> login(String phone, String password) async {
    await MockData.simulateDelay(1200);

    // Validate phone format
    if (phone.isEmpty) {
      throw Exception('Phone number is required');
    }

    if (password.isEmpty) {
      throw Exception('Password is required');
    }

    if (password.length < 6) {
      throw Exception('Invalid credentials');
    }

    // Check credentials against mock database
    if (_mockUsers.containsKey(phone)) {
      final user = _mockUsers[phone]!;
      if (user['password'] == password) {
        _currentUser = User(
          id: 'user_$phone',
          name: user['name']!,
          email: '$phone@adjo.app',
          phone: phone,
          walletAddress: 'G${_generateRandomString(50)}',
          subscription: 'free',
          isVerified: true,
          createdAt: DateTime.now(),
        );

        // Save to local storage
        await StorageService().setString('auth_token', 'token_$phone');
        await StorageService().setString('user_phone', phone);
        await StorageService().setString('user_name', user['name']!);

        return _currentUser!;
      }
    }

    throw Exception('Invalid phone number or password');
  }

  Future<User> signup({
    required String name,
    required String phone,
    required String password,
  }) async {
    await MockData.simulateDelay(1500);

    if (phone.isEmpty || name.isEmpty || password.isEmpty) {
      throw Exception('All fields are required');
    }

    if (password.length < 6) {
      throw Exception('Password must be at least 6 characters');
    }

    if (_mockUsers.containsKey(phone)) {
      throw Exception('This phone number is already registered');
    }

    // Add new user to mock database
    _mockUsers[phone] = {'password': password, 'name': name};

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

    // Save to local storage
    await StorageService().setString('auth_token', 'token_$phone');
    await StorageService().setString('user_phone', phone);
    await StorageService().setString('user_name', name);

    return _currentUser!;
  }

  Future<void> logout() async {
    await MockData.simulateDelay(300);
    _currentUser = null;
  }

  User? getCurrentUser() => _currentUser;

  Future<bool> isAuthenticated() async {
    if (_currentUser != null) return true;

    // Try to restore from storage
    final token = StorageService().getString('auth_token');
    final phone = StorageService().getString('user_phone');

    if (token != null && phone != null) {
      final name = StorageService().getString('user_name') ?? 'User';

      _currentUser = User(
        id: 'user_$phone',
        name: name,
        email: '$phone@adjo.app',
        phone: phone,
        walletAddress: 'G${_generateRandomString(50)}',
        subscription: 'free',
        isVerified: true,
        createdAt: DateTime.now(),
      );
      return true;
    }

    return false;
  }

  Future<void> sendPasswordResetCode(String phone) async {
    await MockData.simulateDelay(800);
    if (!_mockUsers.containsKey(phone)) {
      throw Exception('Phone number not found');
    }
    _verificationCodes[phone] = '12345';
  }

  Future<bool> verifyResetCode(String phone, String code) async {
    await MockData.simulateDelay(500);
    return _verificationCodes[phone] == code;
  }

  Future<void> resetPassword(String phone, String newPassword) async {
    await MockData.simulateDelay(600);
    if (!_mockUsers.containsKey(phone)) {
      throw Exception('Phone number not found');
    }
    if (newPassword.length < 6) {
      throw Exception('Password must be at least 6 characters');
    }
    _mockUsers[phone]!['password'] = newPassword;
  }

  // Get all available test users (for development/testing)
  List<String> getAvailableTestUsers() {
    return _mockUsers.keys.toList();
  }

  String _generateRandomString(int length) {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    return List.generate(length, (i) => chars[(i * 7) % chars.length]).join();
  }
}
