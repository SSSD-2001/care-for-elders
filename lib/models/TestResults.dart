import '../utils/logger.dart';

class TestResults {
  int id;
  String testName;
  String resultValue;
  DateTime date;

  TestResults({
    required this.id,
    required this.testName,
    required this.resultValue,
    required this.date,
  });

  // ---------------- UML Methods ----------------

  void updateResult(String newResult) {
    resultValue = newResult;
    date = DateTime.now();
    AppLogger.info("Test result for $testName updated to $resultValue on $date");
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'testName': testName,
      'resultValue': resultValue,
      'date': date.toIso8601String(),
    };
  }

  factory TestResults.fromJson(Map<String, dynamic> json) {
    return TestResults(
      id: json['id'],
      testName: json['testName'],
      resultValue: json['resultValue'],
      date: DateTime.parse(json['date']),
    );
  }
}
