import '../utils/logger.dart';

class Prescription {
  int id;
  String medicationName;
  String dosage;
  String frequency;
  DateTime startDate;
  DateTime endDate;

  Prescription({
    required this.id,
    required this.medicationName,
    required this.dosage,
    required this.frequency,
    required this.startDate,
    required this.endDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'medicationName': medicationName,
      'dosage': dosage,
      'frequency': frequency,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
    };
  }

  factory Prescription.fromJson(Map<String, dynamic> json) {
    return Prescription(
      id: json['id'],
      medicationName: json['medicationName'],
      dosage: json['dosage'],
      frequency: json['frequency'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
    );
  }

  // Method to update dosage
  void updateDosage(String newDosage) {
    dosage = newDosage;
    AppLogger.info("Prescription #$id dosage updated to: $dosage");
  }

  // Method to set reminder
  void setReminder(DateTime reminderTime) {
    AppLogger.info(
      "Reminder set for $medicationName at ${reminderTime.toString()}",
    );
  }
}
