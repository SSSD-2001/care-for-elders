import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> testBackendConnection() async {
  try {
    print('🔄 Testing backend connection...');
    
    final response = await http.get(
      Uri.parse('http://localhost:3000'),
    );

    if (response.statusCode == 200) {
      print('✅ Backend is connected!');
      print('Response: ${response.body}');
    } else {
      print('❌ Backend returned status: ${response.statusCode}');
    }
  } catch (e) {
    print('❌ Error connecting to backend: $e');
  }
}

void main() async {
  await testBackendConnection();
}
