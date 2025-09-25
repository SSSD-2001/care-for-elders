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