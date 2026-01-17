class ApiConstants {
  // Base URL - Change this to your actual backend URL
  static const String baseUrl = 'http://localhost:3000/api';
  
  // Auth endpoints
  static const String register = '$baseUrl/auth/register';
  static const String login = '$baseUrl/auth/login';
  static const String me = '$baseUrl/auth/me';
  
  // Appointments endpoints
  static const String appointments = '$baseUrl/appointments';
  
  // Medications endpoints
  static const String medications = '$baseUrl/medications';
  
  // Health endpoints
  static const String health = '$baseUrl/health';
  
  // Emergency endpoints
  static const String emergencyContacts = '$baseUrl/emergency/contacts';
  
  // Headers
  static Map<String, String> headers({String? token}) {
    final Map<String, String> defaultHeaders = {
      'Content-Type': 'application/json',
    };
    
    if (token != null) {
      defaultHeaders['Authorization'] = 'Bearer $token';
    }
    
    return defaultHeaders;
  }
}
