import '../utils/logger.dart';

class CommunicationHub {
  int id;
  int userId;
  List<String> messages;

  CommunicationHub({
    required this.id,
    required this.userId,
    required this.messages,
  });

  // ---------------- UML Methods ----------------

  void sendMessage(int toUserId, String content) {
    String msg = "To User $toUserId: $content";
    messages.add(msg);
    AppLogger.info("Message sent: $msg");
  }

  List<String> getMessages() {
    AppLogger.info("Messages for User $userId:");
    return messages;
  }

  // Convert object to a Map (like JSON)
  Map<String, dynamic> toJson() => {
    'id': id,
    'userId': userId,
    'messages': messages,
  };

  // Convert Map back to object
  factory CommunicationHub.fromJson(Map<String, dynamic> json) =>
      CommunicationHub(
        id: json['id'],
        userId: json['userId'],
        messages: List<String>.from(json['messages']),
      );
}
