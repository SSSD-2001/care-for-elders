class MedicationReminder {
    int id;
    int prescriptionId;
    DateTime date;

    MedicationReminder ({
      required this.id,
      required this.prescriptionId,
      required this.date,
    });

    Map<String, dynamic> toJson() {
    return {
      'id': id,
      'prescriptionId': prescriptionId,
      'date': date.toIso8601String(),
    };
  }
  factory MedicationReminder.fromJson(Map<String, dynamic> json) {
    return MedicationReminder(
      id: json['id'],
      prescriptionId: json['prescriptionId'],
      date: DateTime.parse(json['date']),
    );
  }
}