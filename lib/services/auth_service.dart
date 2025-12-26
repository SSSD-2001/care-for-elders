import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import '../constants/app_constants.dart';
import '../models/User.dart';
import '../utils/logger.dart';
import 'firestore_service.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  final firebase_auth.FirebaseAuth _firebaseAuth = firebase_auth.FirebaseAuth.instance;
  final FirestoreService _firestoreService = FirestoreService();

  User? _currentUser;

  User? get currentUser => _currentUser;

  bool get isLoggedIn => _currentUser != null;

  // Get Firebase User
  firebase_auth.User? get firebaseUser => _firebaseAuth.currentUser;

  // Initialize and check if user is logged in
  Future<bool> initialize() async {
    try {
      final firebaseUser = _firebaseAuth.currentUser;

      if (firebaseUser != null) {
        // User is logged in, fetch user data from Firestore
        final userDoc = await _firestoreService.getUser(firebaseUser.uid);

        if (userDoc.exists) {
          final userData = userDoc.data() as Map<String, dynamic>;
          _currentUser = User.fromMap(userData);
          AppLogger.info('User session restored: ${_currentUser!.name}');
          return true;
        }
      }

      return false;
    } catch (e) {
      AppLogger.error('Error initializing auth service: $e');
      return false;
    }
  }

  // Login
  Future<bool> login(String email, String password) async {
    try {
      // Sign in with Firebase
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        // Fetch user data from Firestore
        final userDoc = await _firestoreService.getUser(userCredential.user!.uid);

        if (userDoc.exists) {
          final userData = userDoc.data() as Map<String, dynamic>;
          _currentUser = User.fromMap(userData);

          // Save to SharedPreferences
          final prefs = await SharedPreferences.getInstance();
          await prefs.setBool(AppConstants.keyIsLoggedIn, true);
          await prefs.setString(AppConstants.keyUserId, _currentUser!.userId);
          await prefs.setString(AppConstants.keyUserName, _currentUser!.name);
          await prefs.setString(AppConstants.keyUserEmail, _currentUser!.email);

          AppLogger.info('User logged in: ${_currentUser!.name}');
          return true;
        }
      }
      return false;
    } catch (e) {
      AppLogger.error('Login error: $e');
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
      // Create Firebase user
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        // Create user object
        _currentUser = User(
          userId: userCredential.user!.uid,
          name: name,
          email: email,
          password: '', // Don't store password
          phoneNumber: phoneNumber,
          dateOfBirth: dateOfBirth,
          address: '',
          emergencyContacts: [],
          bloodType: '',
          allergies: [],
          role: 'Elder',
        );

        // Save user data to Firestore
        await _firestoreService.createUser(
          _currentUser!.userId,
          _currentUser!.toMap(),
        );

        // Save to SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool(AppConstants.keyIsLoggedIn, true);
        await prefs.setString(AppConstants.keyUserId, _currentUser!.userId);
        await prefs.setString(AppConstants.keyUserName, _currentUser!.name);
        await prefs.setString(AppConstants.keyUserEmail, _currentUser!.email);

        AppLogger.info('User registered: ${_currentUser!.name}');
        return true;
      }
      return false;
    } catch (e) {
      AppLogger.error('Registration error: $e');
      return false;
    }
  }

  // Logout
  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      _currentUser = null;
      AppLogger.info('User logged out');
    } catch (e) {
      AppLogger.error('Logout error: $e');
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
      final updates = <String, dynamic>{};

      if (name != null) {
        _currentUser!.name = name;
        updates['name'] = name;
      }
      if (email != null) {
        _currentUser!.email = email;
        updates['email'] = email;
      }
      if (phoneNumber != null) {
        _currentUser!.phoneNumber = phoneNumber;
        updates['phoneNumber'] = phoneNumber;
      }
      if (address != null) {
        _currentUser!.address = address;
        updates['address'] = address;
      }

      // Update Firestore
      if (updates.isNotEmpty) {
        await _firestoreService.updateUser(_currentUser!.userId, updates);
      }

      // Update SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      if (name != null) await prefs.setString(AppConstants.keyUserName, name);
      if (email != null) await prefs.setString(AppConstants.keyUserEmail, email);

      AppLogger.info('Profile updated');
      return true;
    } catch (e) {
      AppLogger.error('Profile update error: $e');
      return false;
    }
  }

  // Reset Password
  Future<bool> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      AppLogger.info('Password reset email sent to: $email');
      return true;
    } catch (e) {
      AppLogger.error('Password reset error: $e');
      return false;
    }
  }
}

