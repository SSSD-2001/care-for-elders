class Activity {
  int id;
  String type;
  int duration;
  DateTime date;

  Activity({
    required this.id,
    required this.type,
    required this.duration,
    required this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'duration': duration,
      'date': date.toIso8601String(),
    };
  }

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      id: json['id'],
      type: json['type'],
      duration: json['duration'],
      date: DateTime.parse(json['date']),
    );
  }

  // Method to update activity duration
  void updateDuration(int newDuration) {
    duration = newDuration;
  }
}
