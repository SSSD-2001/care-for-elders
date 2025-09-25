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
}