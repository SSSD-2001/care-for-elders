import '../utils/logger.dart';

class Emergencycontact {
  String contactId;
  String userId;
  String name;
  String phoneNumber;
  String relationship;
  int priority;
  bool isNotified;

  Emergencycontact({
    required this.contactId,
    required this.userId,
    required this.name,
    required this.phoneNumber,
    required this.relationship,
    required this.priority,
    required this.isNotified,
  });

  // ---------------- UML Methods ----------------

  void notifyEmergency() {
    isNotified = true;
    AppLogger.info("🚨 Emergency! Notifying $name at $phoneNumber");
  }

  String getContactInfo() {
    return "👤 $name ($relationship), 📞 $phoneNumber, Priority: $priority";
  }

  Map<String, dynamic> toJson() {
    return {
      'contactId': contactId,
      'userId': userId,
      'name': name,
      'phoneNumber': phoneNumber,
      'relationship': relationship,
      'priority': priority,
      'isNotified': isNotified,
    };
  }

  factory Emergencycontact.fromJson(Map<String, dynamic> json) {
    return Emergencycontact(
      contactId: json['contactId'],
      userId: json['userId'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      relationship: json['relationship'],
      priority: json['priority'],
      isNotified: json['isNotified'],
    );
  }
}
