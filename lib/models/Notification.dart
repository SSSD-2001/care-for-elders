class Notification {
    String notificationId;
    String userId;
    String message;
    String title;
    String type;
    DateTime dateTime;
    bool isRead;

    Notification({
        required this.notificationId,
        required this.userId,
        required this.message,
        required this.title,
        required this.type,
        required this.dateTime,
        required this.isRead,
    });
    
    Map<String, dynamic> toJson() {
      return {
        'notificationId': notificationId,
        'userId': userId,
        'message': message,
        'title': title,
        'type': type,
        'dateTime': dateTime.toIso8601String(),
        'isRead': isRead,
      };
    }

    factory Notification.fromJson(Map<String, dynamic> json) {
      return Notification(
        notificationId: json['notificationId'],
        userId: json['userId'],
        message: json['message'],
        title: json['title'],
        type: json['type'],
        dateTime: DateTime.parse(json['dateTime']),
        isRead: json['isRead'],
      );
    }
}