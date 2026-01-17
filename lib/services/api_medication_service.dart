import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/api_constants.dart';
import '../models/Medication.dart';
import '../utils/logger.dart';
import 'api_auth_service.dart';

class ApiMedicationService {
  final _authService = ApiAuthService();

  // Get all medications
  Future<List<Medication>> getMedications() async {
    try {
      final response = await http.get(
        Uri.parse(ApiConstants.medications),
        headers: ApiConstants.headers(token: _authService.token),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Medication.fromJson(json)).toList();
      } else {
        AppLogger.info('Failed to load medications: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      AppLogger.info('Error fetching medications: $e');
      return [];
    }
  }

  // Create medication
  Future<Map<String, dynamic>> createMedication(Medication medication) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConstants.medications),
        headers: ApiConstants.headers(token: _authService.token),
        body: json.encode(medication.toJson()),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return {'success': true, 'medication': Medication.fromJson(data)};
      } else {
        return {'success': false, 'message': 'Failed to create medication'};
      }
    } catch (e) {
      AppLogger.info('Error creating medication: $e');
      return {'success': false, 'message': 'Network error'};
    }
  }

  // Update medication
  Future<Map<String, dynamic>> updateMedication(String id, Map<String, dynamic> updates) async {
    try {
      final response = await http.put(
        Uri.parse('${ApiConstants.medications}/$id'),
        headers: ApiConstants.headers(token: _authService.token),
        body: json.encode(updates),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return {'success': true, 'medication': Medication.fromJson(data)};
      } else {
        return {'success': false, 'message': 'Failed to update medication'};
      }
    } catch (e) {
      AppLogger.info('Error updating medication: $e');
      return {'success': false, 'message': 'Network error'};
    }
  }

  // Delete medication
  Future<bool> deleteMedication(String id) async {
    try {
      final response = await http.delete(
        Uri.parse('${ApiConstants.medications}/$id'),
        headers: ApiConstants.headers(token: _authService.token),
      );

      return response.statusCode == 200;
    } catch (e) {
      AppLogger.info('Error deleting medication: $e');
      return false;
    }
  }
}
