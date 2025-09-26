import '../utils/logger.dart';

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

  // Method to send notification
  void sendNotification() {
    AppLogger.info("Notification sent: $title - $message");
  }

  // Method to mark notification as read
  void markAsRead() {
    isRead = true;
    AppLogger.info("Notification '$title' marked as read");
  }

  // Static method to get unread count from a list of notifications
  static int getUnreadCount(List<Notification> notifications) {
    return notifications.where((notification) => !notification.isRead).length;
  }
}
