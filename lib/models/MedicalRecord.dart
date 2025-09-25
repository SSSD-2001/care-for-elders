class MedicalRecord {
  int recordId;
  int userId;
  String title;
  DateTime date;
  String description;
  List<String> perscriptions;
  String fileUrl;
  List<String> testResults;
  String category;
  List<String> diagnosis;

  MedicalRecord({
    required this.recordId,
    required this.userId,
    required this.title,
    required this.date,
    required this.description,
    required this.perscriptions,
    required this.fileUrl,
    required this.testResults,
    required this.category,
    required this.diagnosis,
  });

  Map<String, dynamic> toJson() {
    return {
      'recordId': recordId,
      'userId': userId,
      'title': title,
      'date': date.toIso8601String(),
      'description': description,
      'perscriptions': perscriptions,
      'fileUrl': fileUrl,
      'testResults': testResults,
      'category': category,
      'diagnosis': diagnosis,
    };
  }

  factory MedicalRecord.fromJson(Map<String, dynamic> json) {
    return MedicalRecord(
      recordId: json['recordId'],
      userId: json['userId'],
      title: json['title'],
      date: DateTime.parse(json['date']),
      description: json['description'],
      perscriptions: List<String>.from(json['perscriptions']),
      fileUrl: json['fileUrl'],
      testResults: List<String>.from(json['testResults']),
      category: json['category'],
      diagnosis: List<String>.from(json['diagnosis']),
    );
  }
}