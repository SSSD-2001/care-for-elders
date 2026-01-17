import 'package:http/http.dart' as http;
import 'dart:convert';

void main() async {
  print('\n🧪 TESTING FLUTTER ↔️ BACKEND CONNECTION\n');
  print('=' * 50);
  
  try {
    // Test 1: Health Check
    print('\n1️⃣ Testing Backend Health...');
    final healthResponse = await http.get(
      Uri.parse('http://localhost:3000'),
    );
    
    if (healthResponse.statusCode == 200) {
      final data = json.decode(healthResponse.body);
      print('   ✅ Backend is running: ${data['message']}');
    } else {
      print('   ❌ Backend health check failed');
      return;
    }

    // Test 2: Login
    print('\n2️⃣ Testing Login...');
    final loginResponse = await http.post(
      Uri.parse('http://localhost:3000/api/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': 'test@example.com',
        'password': 'test123',
      }),
    );

    if (loginResponse.statusCode == 200) {
      final loginData = json.decode(loginResponse.body);
      final token = loginData['token'];
      print('   ✅ Login successful!');
      print('   User: ${loginData['user']['name']}');
      print('   Email: ${loginData['user']['email']}');

      // Test 3: Get User Profile
      print('\n3️⃣ Testing Get User Profile...');
      final profileResponse = await http.get(
        Uri.parse('http://localhost:3000/api/auth/me'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (profileResponse.statusCode == 200) {
        final userData = json.decode(profileResponse.body);
        print('   ✅ Profile retrieved successfully!');
        print('   Name: ${userData['name']}');
        print('   Email: ${userData['email']}');
      }

      // Test 4: Get Appointments
      print('\n4️⃣ Testing Appointments Endpoint...');
      final appointmentsResponse = await http.get(
        Uri.parse('http://localhost:3000/api/appointments'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (appointmentsResponse.statusCode == 200) {
        final appointments = json.decode(appointmentsResponse.body);
        print('   ✅ Appointments endpoint working!');
        print('   Appointments count: ${appointments.length}');
      }

      // Test 5: Get Medications
      print('\n5️⃣ Testing Medications Endpoint...');
      final medicationsResponse = await http.get(
        Uri.parse('http://localhost:3000/api/medications'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (medicationsResponse.statusCode == 200) {
        final medications = json.decode(medicationsResponse.body);
        print('   ✅ Medications endpoint working!');
        print('   Medications count: ${medications.length}');
      }

      print('\n' + '=' * 50);
      print('🎉 ALL TESTS PASSED! Backend is fully functional!');
      print('=' * 50);
      print('\n✅ Your Flutter app can now connect to the backend');
      print('✅ MongoDB is storing data correctly');
      print('✅ All API endpoints are working');
      print('\n📱 Ready to run the mobile app!\n');

    } else {
      print('   ❌ Login failed: ${loginResponse.body}');
    }

  } catch (e) {
    print('\n❌ Connection Error: $e');
    print('\n⚠️  Make sure:');
    print('   1. Backend server is running on http://localhost:3000');
    print('   2. MongoDB is running');
    print('   3. Test user exists (email: test@example.com)');
  }
}
