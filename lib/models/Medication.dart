import '../utils/logger.dart';

class Medication {
  String medicationId;
  String userId;
  String name;
  String dosage;
  String frequency;
  DateTime startDate;
  DateTime endDate;
  String instructions;
  int remainingQuantity;

  Medication({
    required this.medicationId,
    required this.userId,
    required this.name,
    required this.dosage,
    required this.frequency,
    required this.startDate,
    required this.endDate,
    required this.instructions,
    required this.remainingQuantity,
  });

  Map<String, dynamic> toJson() {
    return {
      'medicationId': medicationId,
      'userId': userId,
      'name': name,
      'dosage': dosage,
      'frequency': frequency,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'instructions': instructions,
      'remainingQuantity': remainingQuantity,
    };
  }

  factory Medication.fromJson(Map<String, dynamic> json) {
    return Medication(
      medicationId: json['medicationId'],
      userId: json['userId'],
      name: json['name'],
      dosage: json['dosage'],
      frequency: json['frequency'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      instructions: json['instructions'],
      remainingQuantity: json['remainingQuantity'],
    );
  }

  // Method to create reminder
  void createReminder() {
    // Logic for creating medication reminder
    AppLogger.info("Reminder created for $name - $dosage, $frequency");
  }

  // Method to mark medication as taken
  void markAsTaken() {
    remainingQuantity--;
    AppLogger.info(
      "$name marked as taken. Remaining quantity: $remainingQuantity",
    );
  }

  // Method to alert for refill
  void refillAlert() {
    if (remainingQuantity < 5) {
      AppLogger.info(
        "ALERT: Low stock for $name. Only $remainingQuantity doses remaining!",
      );
    }
  }
}
