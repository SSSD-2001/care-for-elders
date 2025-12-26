import 'package:shared_preferences/shared_preferences.dart';
import '../constants/app_constants.dart';
import '../models/User.dart';
import '../utils/logger.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  User? _currentUser;

  User? get currentUser => _currentUser;

  bool get isLoggedIn => _currentUser != null;

  // Initialize and check if user is logged in
  Future<bool> initialize() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final isLoggedIn = prefs.getBool(AppConstants.keyIsLoggedIn) ?? false;

      if (isLoggedIn) {
        final userId = prefs.getString(AppConstants.keyUserId);
        final userName = prefs.getString(AppConstants.keyUserName);
        final userEmail = prefs.getString(AppConstants.keyUserEmail);

        if (userId != null && userName != null && userEmail != null) {
          // Restore user session (simplified version)
          _currentUser = User(
            userId: userId,
            name: userName,
            email: userEmail,
            password: '', // Don't store passwords in SharedPreferences
            phoneNumber: '',
            dateOfBirth: DateTime.now(),
            address: '',
            emergencyContacts: [],
            bloodType: '',
            allergies: [],
            role: 'Elder',
          );
          AppLogger.info('User session restored: ${_currentUser!.name}');
          return true;
        }
      }
      return false;
    } catch (e) {
      AppLogger.info('Error initializing auth service: $e');
      return false;
    }
  }

  // Login
  Future<bool> login(String email, String password) async {
    try {
      // TODO: Replace with actual API call
      // For now, using dummy authentication
      if (email.isNotEmpty && password.length >= 4) {
        _currentUser = User(
          userId: 'u1',
          name: 'John Doe',
          email: email,
          password: password,
          phoneNumber: '+1234567890',
          dateOfBirth: DateTime(1950, 1, 1),
          address: '123 Main Street',
          emergencyContacts: ['Alice', 'Bob'],
          bloodType: 'O+',
          allergies: ['Penicillin'],
          role: 'Elder',
        );

        // Save to SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool(AppConstants.keyIsLoggedIn, true);
        await prefs.setString(AppConstants.keyUserId, _currentUser!.userId);
        await prefs.setString(AppConstants.keyUserName, _currentUser!.name);
        await prefs.setString(AppConstants.keyUserEmail, _currentUser!.email);

        AppLogger.info('User logged in: ${_currentUser!.name}');
        return true;
      }
      return false;
    } catch (e) {
      AppLogger.info('Login error: $e');
      return false;
    }
  }

  // Register
  Future<bool> register({
    required String name,
    required String email,
    required String password,
    required String phoneNumber,
    required DateTime dateOfBirth,
  }) async {
    try {
      // TODO: Replace with actual API call
      _currentUser = User(
        userId: 'u_${DateTime.now().millisecondsSinceEpoch}',
        name: name,
        email: email,
        password: password,
        phoneNumber: phoneNumber,
        dateOfBirth: dateOfBirth,
        address: '',
        emergencyContacts: [],
        bloodType: '',
        allergies: [],
        role: 'Elder',
      );

      // Save to SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(AppConstants.keyIsLoggedIn, true);
      await prefs.setString(AppConstants.keyUserId, _currentUser!.userId);
      await prefs.setString(AppConstants.keyUserName, _currentUser!.name);
      await prefs.setString(AppConstants.keyUserEmail, _currentUser!.email);

      AppLogger.info('User registered: ${_currentUser!.name}');
      return true;
    } catch (e) {
      AppLogger.info('Registration error: $e');
      return false;
    }
  }

  // Logout
  Future<void> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      _currentUser = null;
      AppLogger.info('User logged out');
    } catch (e) {
      AppLogger.info('Logout error: $e');
    }
  }

  // Update profile
  Future<bool> updateProfile({
    String? name,
    String? email,
    String? phoneNumber,
    String? address,
  }) async {
    if (_currentUser == null) return false;

    try {
      if (name != null) _currentUser!.name = name;
      if (email != null) _currentUser!.email = email;
      if (phoneNumber != null) _currentUser!.phoneNumber = phoneNumber;
      if (address != null) _currentUser!.address = address;

      // Update SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      if (name != null) await prefs.setString(AppConstants.keyUserName, name);
      if (email != null) await prefs.setString(AppConstants.keyUserEmail, email);

      AppLogger.info('Profile updated');
      return true;
    } catch (e) {
      AppLogger.info('Profile update error: $e');
      return false;
    }
  }
}

