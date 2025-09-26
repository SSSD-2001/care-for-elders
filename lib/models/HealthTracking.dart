import 'VitalSign.dart';
import 'Activity.dart';

import '../utils/logger.dart';

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

  // ---------------- UML Methods ----------------

  void logVitalSign(VitalSign vitalSign) {
    vitalSigns.add("${vitalSign.type}: ${vitalSign.value}");
    AppLogger.info(
      "🩺 Logged vital sign: ${vitalSign.type} = ${vitalSign.value}",
    );
  }

  void logActivity(Activity activity) {
    activityLog.add("${activity.type} - ${activity.duration} mins");
    AppLogger.info(
      "🏃 Logged activity: ${activity.type} for ${activity.duration} mins",
    );
  }

  String getHealthProgress() {
    return "📊 Health Tracker [$trackerId] progress: $value $unit";
  }

  void viewHistory() {
    AppLogger.info("📜 Health History for $trackerId:");
    AppLogger.info("   Vital Signs: ${vitalSigns.join(", ")}");
    AppLogger.info("   Activities: ${activityLog.join(", ")}");
  }

  void generateReport() {
    AppLogger.info("📝 Generating health report for user $userId...");
    AppLogger.info(getHealthProgress());
    viewHistory();
  }

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
