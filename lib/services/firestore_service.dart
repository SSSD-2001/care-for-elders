import 'package:cloud_firestore/cloud_firestore.dart';
import '../utils/logger.dart';

/// Service class for Firestore database operations
class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // User Collection
  Future<void> createUser(String userId, Map<String, dynamic> userData) async {
    try {
      await _firestore.collection('users').doc(userId).set(userData);
      AppLogger.info('User created successfully: $userId');
    } catch (e) {
      AppLogger.error('Error creating user: $e');
      rethrow;
    }
  }

  Future<DocumentSnapshot> getUser(String userId) async {
    try {
      return await _firestore.collection('users').doc(userId).get();
    } catch (e) {
      AppLogger.error('Error getting user: $e');
      rethrow;
    }
  }

  Future<void> updateUser(String userId, Map<String, dynamic> updates) async {
    try {
      await _firestore.collection('users').doc(userId).update(updates);
      AppLogger.info('User updated successfully: $userId');
    } catch (e) {
      AppLogger.error('Error updating user: $e');
      rethrow;
    }
  }

  // Health Tracking Collection
  Future<void> addHealthTracking(String userId, Map<String, dynamic> data) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('health_tracking')
          .add(data);
      AppLogger.info('Health tracking data added');
    } catch (e) {
      AppLogger.error('Error adding health tracking: $e');
      rethrow;
    }
  }

  Stream<QuerySnapshot> getHealthTrackingStream(String userId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('health_tracking')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  // Medications Collection
  Future<void> addMedication(String userId, Map<String, dynamic> medication) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('medications')
          .add(medication);
      AppLogger.info('Medication added');
    } catch (e) {
      AppLogger.error('Error adding medication: $e');
      rethrow;
    }
  }

  Stream<QuerySnapshot> getMedicationsStream(String userId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('medications')
        .snapshots();
  }

  Future<void> updateMedication(
      String userId, String medicationId, Map<String, dynamic> updates) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('medications')
          .doc(medicationId)
          .update(updates);
      AppLogger.info('Medication updated');
    } catch (e) {
      AppLogger.error('Error updating medication: $e');
      rethrow;
    }
  }

  Future<void> deleteMedication(String userId, String medicationId) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('medications')
          .doc(medicationId)
          .delete();
      AppLogger.info('Medication deleted');
    } catch (e) {
      AppLogger.error('Error deleting medication: $e');
      rethrow;
    }
  }

  // Appointments Collection
  Future<void> addAppointment(String userId, Map<String, dynamic> appointment) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('appointments')
          .add(appointment);
      AppLogger.info('Appointment added');
    } catch (e) {
      AppLogger.error('Error adding appointment: $e');
      rethrow;
    }
  }

  Stream<QuerySnapshot> getAppointmentsStream(String userId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('appointments')
        .orderBy('dateTime', descending: false)
        .snapshots();
  }

  Future<void> updateAppointment(
      String userId, String appointmentId, Map<String, dynamic> updates) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('appointments')
          .doc(appointmentId)
          .update(updates);
      AppLogger.info('Appointment updated');
    } catch (e) {
      AppLogger.error('Error updating appointment: $e');
      rethrow;
    }
  }

  Future<void> deleteAppointment(String userId, String appointmentId) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('appointments')
          .doc(appointmentId)
          .delete();
      AppLogger.info('Appointment deleted');
    } catch (e) {
      AppLogger.error('Error deleting appointment: $e');
      rethrow;
    }
  }

  // Emergency Contacts Collection
  Future<void> addEmergencyContact(
      String userId, Map<String, dynamic> contact) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('emergency_contacts')
          .add(contact);
      AppLogger.info('Emergency contact added');
    } catch (e) {
      AppLogger.error('Error adding emergency contact: $e');
      rethrow;
    }
  }

  Stream<QuerySnapshot> getEmergencyContactsStream(String userId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('emergency_contacts')
        .snapshots();
  }

  // Medical Records Collection
  Future<void> addMedicalRecord(
      String userId, Map<String, dynamic> record) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('medical_records')
          .add(record);
      AppLogger.info('Medical record added');
    } catch (e) {
      AppLogger.error('Error adding medical record: $e');
      rethrow;
    }
  }

  Stream<QuerySnapshot> getMedicalRecordsStream(String userId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('medical_records')
        .orderBy('date', descending: true)
        .snapshots();
  }
}

