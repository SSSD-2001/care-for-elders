class HealthTracking {
    String userId;
    String trackerId;
    String type;
    DateTime date;
    List<String> vitalSigns;
    double value;
    String unit;
    List<String> activityLog;
    
    HealthTracking({
        required this.userId,
        required this.trackerId,
        required this.type,
        required this.date,
        required this.vitalSigns,
        required this.value,
        required this.unit,
        required this.activityLog,
    });

    Map<String, dynamic> toJson() {
      return {
        'userId': userId,
        'trackerId': trackerId,
        'type': type,
        'date': date.toIso8601String(),
        'vitalSigns': vitalSigns,
        'value': value,
        'unit': unit,
        'activityLog': activityLog,
      };
    }

    factory HealthTracking.fromJson(Map<String, dynamic> json) {
      return HealthTracking(
        userId: json['userId'],
        trackerId: json['trackerId'],
        type: json['type'],
        date: DateTime.parse(json['date']),
        vitalSigns: List<String>.from(json['vitalSigns']),
        value: json['value'],
        unit: json['unit'],
        activityLog: List<String>.from(json['activityLog']),
      );
    }

}