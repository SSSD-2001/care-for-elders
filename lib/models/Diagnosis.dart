class Diagnosis {
    int id;
    String description;
    DateTime date;

    Diagnosis({
      required this.id,
      required this.description,
      required this.date,
    });

    Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'date': date.toIso8601String(),
    };
  }
  factory Diagnosis.fromJson(Map<String, dynamic> json) {
    return Diagnosis(
      id: json['id'],
      description: json['description'],
      date: DateTime.parse(json['date']),
    );
  }
}