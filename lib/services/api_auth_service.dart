import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/api_constants.dart';
import '../models/User.dart';
import '../utils/logger.dart';

class ApiAuthService {
  static final ApiAuthService _instance = ApiAuthService._internal();
  factory ApiAuthService() => _instance;
  ApiAuthService._internal();

  String? _token;
  User? _currentUser;

  User? get currentUser => _currentUser;
  bool get isLoggedIn => _token != null && _currentUser != null;
  String? get token => _token;

  // Initialize and check if user has saved token
  Future<bool> initialize() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _token = prefs.getString('auth_token');
      
      if (_token != null) {
        // Verify token is still valid by fetching user data
        final response = await http.get(
          Uri.parse(ApiConstants.me),
          headers: ApiConstants.headers(token: _token),
        );

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          _currentUser = User.fromJson(data);
          AppLogger.info('User session restored: ${_currentUser!.name}');
          return true;
        } else {
          // Token is invalid, clear it
          await logout();
        }
      }
      return false;
    } catch (e) {
      AppLogger.info('Error initializing auth service: $e');
      return false;
    }
  }

  // Register new user
  Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
    String? phoneNumber,
    DateTime? dateOfBirth,
    String? address,
    String? bloodType,
    List<String>? allergies,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConstants.register),
        headers: ApiConstants.headers(),
        body: json.encode({
          'name': name,
          'email': email,
          'password': password,
          'phoneNumber': phoneNumber,
          'dateOfBirth': dateOfBirth?.toIso8601String(),
          'address': address,
          'bloodType': bloodType,
          'allergies': allergies,
        }),
      );

      final data = json.decode(response.body);

      if (response.statusCode == 200) {
        _token = data['token'];
        _currentUser = User.fromJson(data['user']);
        
        // Save token
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', _token!);
        
        AppLogger.info('User registered successfully: ${_currentUser!.name}');
        return {'success': true, 'user': _currentUser};
      } else {
        return {'success': false, 'message': data['message'] ?? 'Registration failed'};
      }
    } catch (e) {
      AppLogger.info('Error during registration: $e');
      return {'success': false, 'message': 'Network error. Please try again.'};
    }
  }

  // Login user
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConstants.login),
        headers: ApiConstants.headers(),
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );

      final data = json.decode(response.body);

      if (response.statusCode == 200) {
        _token = data['token'];
        _currentUser = User.fromJson(data['user']);
        
        // Save token
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', _token!);
        
        AppLogger.info('User logged in successfully: ${_currentUser!.name}');
        return {'success': true, 'user': _currentUser};
      } else {
        return {'success': false, 'message': data['message'] ?? 'Login failed'};
      }
    } catch (e) {
      AppLogger.info('Error during login: $e');
      return {'success': false, 'message': 'Network error. Please try again.'};
    }
  }

  // Logout user
  Future<void> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('auth_token');
      _token = null;
      _currentUser = null;
      AppLogger.info('User logged out successfully');
    } catch (e) {
      AppLogger.info('Error during logout: $e');
    }
  }

  // Update user profile
  Future<Map<String, dynamic>> updateProfile(Map<String, dynamic> updates) async {
    try {
      // This endpoint needs to be added to backend
      final response = await http.put(
        Uri.parse('${ApiConstants.me}'),
        headers: ApiConstants.headers(token: _token),
        body: json.encode(updates),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _currentUser = User.fromJson(data);
        return {'success': true, 'user': _currentUser};
      } else {
        return {'success': false, 'message': 'Update failed'};
      }
    } catch (e) {
      AppLogger.info('Error updating profile: $e');
      return {'success': false, 'message': 'Network error'};
    }
  }
}
