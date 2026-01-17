import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/api_constants.dart';
import '../models/HealthTracking.dart';
import '../utils/logger.dart';
import 'api_auth_service.dart';

class ApiHealthService {
  final _authService = ApiAuthService();

  // Get health records
  Future<List<dynamic>> getHealthRecords({String? type, DateTime? startDate, DateTime? endDate}) async {
    try {
      final queryParams = <String, String>{};
      if (type != null) queryParams['type'] = type;
      if (startDate != null) queryParams['startDate'] = startDate.toIso8601String();
      if (endDate != null) queryParams['endDate'] = endDate.toIso8601String();

      final uri = Uri.parse(ApiConstants.health).replace(queryParameters: queryParams);
      
      final response = await http.get(
        uri,
        headers: ApiConstants.headers(token: _authService.token),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data;
      } else {
        AppLogger.info('Failed to load health records: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      AppLogger.info('Error fetching health records: $e');
      return [];
    }
  }

  // Create health record
  Future<Map<String, dynamic>> createHealthRecord(Map<String, dynamic> record) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConstants.health),
        headers: ApiConstants.headers(token: _authService.token),
        body: json.encode(record),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return {'success': true, 'record': data};
      } else {
        return {'success': false, 'message': 'Failed to create health record'};
      }
    } catch (e) {
      AppLogger.info('Error creating health record: $e');
      return {'success': false, 'message': 'Network error'};
    }
  }

  // Delete health record
  Future<bool> deleteHealthRecord(String id) async {
    try {
      final response = await http.delete(
        Uri.parse('${ApiConstants.health}/$id'),
        headers: ApiConstants.headers(token: _authService.token),
      );

      return response.statusCode == 200;
    } catch (e) {
      AppLogger.info('Error deleting health record: $e');
      return false;
    }
  }
}
