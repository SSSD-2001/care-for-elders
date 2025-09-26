class Message {
  int id;
  int fromUserId;
  int toUserId;
  String
  content; // In a real app, passwords should be hashed and handled securely
  DateTime timestamp;

  Message({
    required this.id,
    required this.fromUserId,
    required this.toUserId,
    required this.content,
    required this.timestamp,
  });

  // Convert object to a Map (like JSON)
  // Note: timestamp is converted to ISO8601 string for easier serialization
  Map<String, dynamic> toJson() => {
    'id': id,
    'fromUserId': fromUserId,
    'toUserId': toUserId,
    'content': content,
    'timestamp': timestamp.toIso8601String(),
  };

  // Convert Map back to object
  factory Message.fromJson(Map<String, dynamic> json) => Message(
    id: json['id'],
    fromUserId: json['fromUserId'],
    toUserId: json['toUserId'],
    content: json['content'],
    timestamp: DateTime.parse(json['timestamp']),
  );

  // Method to get message details
  String getMessageDetails() {
    return "Message #$id from User $fromUserId to User $toUserId at ${timestamp.toString()}: $content";
  }
}
