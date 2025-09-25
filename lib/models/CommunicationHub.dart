class CommunicationHub {
  int id;
  int userId;
  List<String> messages;

  CommunicationHub({
    required this.id,
    required this.userId,
    required this.messages,
  });

  // Convert object to a Map (like JSON)
  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'messages': messages,
      };
    
  // Convert Map back to object
  factory CommunicationHub.fromJson(Map<String, dynamic> json) => CommunicationHub(
        id: json['id'],
        userId: json['userId'],
        messages: List<String>.from(json['messages']),
      );

}