import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/api_constants.dart';
import '../models/Appointment.dart';
import '../utils/logger.dart';
import 'api_auth_service.dart';

class ApiAppointmentService {
  final _authService = ApiAuthService();

  // Get all appointments
  Future<List<Appointment>> getAppointments() async {
    try {
      final response = await http.get(
        Uri.parse(ApiConstants.appointments),
        headers: ApiConstants.headers(token: _authService.token),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Appointment.fromJson(json)).toList();
      } else {
        AppLogger.info('Failed to load appointments: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      AppLogger.info('Error fetching appointments: $e');
      return [];
    }
  }

  // Create appointment
  Future<Map<String, dynamic>> createAppointment(Appointment appointment) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConstants.appointments),
        headers: ApiConstants.headers(token: _authService.token),
        body: json.encode(appointment.toJson()),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return {'success': true, 'appointment': Appointment.fromJson(data)};
      } else {
        return {'success': false, 'message': 'Failed to create appointment'};
      }
    } catch (e) {
      AppLogger.info('Error creating appointment: $e');
      return {'success': false, 'message': 'Network error'};
    }
  }

  // Update appointment
  Future<Map<String, dynamic>> updateAppointment(String id, Map<String, dynamic> updates) async {
    try {
      final response = await http.put(
        Uri.parse('${ApiConstants.appointments}/$id'),
        headers: ApiConstants.headers(token: _authService.token),
        body: json.encode(updates),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return {'success': true, 'appointment': Appointment.fromJson(data)};
      } else {
        return {'success': false, 'message': 'Failed to update appointment'};
      }
    } catch (e) {
      AppLogger.info('Error updating appointment: $e');
      return {'success': false, 'message': 'Network error'};
    }
  }

  // Delete appointment
  Future<bool> deleteAppointment(String id) async {
    try {
      final response = await http.delete(
        Uri.parse('${ApiConstants.appointments}/$id'),
        headers: ApiConstants.headers(token: _authService.token),
      );

      return response.statusCode == 200;
    } catch (e) {
      AppLogger.info('Error deleting appointment: $e');
      return false;
    }
  }
}
