import '../utils/logger.dart';

class VitalSign {
  int id;
  String type;
  String value;
  DateTime date;

  VitalSign({
    required this.id,
    required this.type,
    required this.value,
    required this.date,
  });

  // ---------------- UML Methods ----------------

  void updateValue(String newValue) {
    value = newValue;
    date = DateTime.now(); // update timestamp whenever value changes
    AppLogger.info(" Vital sign '$type' updated to $value at $date");
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'value': value,
      'date': date.toIso8601String(),
    };
  }

  factory VitalSign.fromJson(Map<String, dynamic> json) {
    return VitalSign(
      id: json['id'],
      type: json['type'],
      value: json['value'],
      date: DateTime.parse(json['date']),
    );
  }
}
