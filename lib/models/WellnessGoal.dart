import '../utils/logger.dart';

class WellnessGoal {
  int id;
  String userId;
  String goalDescription;
  String targetValue;
  String progress;

  WellnessGoal({
    required this.id,
    required this.userId,
    required this.goalDescription,
    required this.targetValue,
    required this.progress,
  });
  // ---------------- UML Methods ----------------

  void setGoal(String newGoalDescription, String newTargetValue) {
    goalDescription = newGoalDescription;
    targetValue = newTargetValue;
    progress = "0%"; // reset progress
    AppLogger.info("🎯 Goal set: $goalDescription, Target: $targetValue");
  }

  void updateProgress(String newProgress) {
    progress = newProgress;
    AppLogger.info("📊 Progress updated: $progress for goal '$goalDescription'");
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'goalDescription': goalDescription,
      'targetValue': targetValue,
      'progress': progress,
    };
  }

  factory WellnessGoal.fromJson(Map<String, dynamic> json) {
    return WellnessGoal(
      id: json['id'],
      userId: json['userId'],
      goalDescription: json['goalDescription'],
      targetValue: json['targetValue'],
      progress: json['progress'],
    );
  }
}
