class Appointment {
    String appointmentId;
    String userId;
    int doctorId;
    DateTime appointmentDate;
    String status;
    String purpose;
    String location;
    String notes;
    bool reminder;

  Appointment({
    required this.appointmentId,
    required this.userId,
    required this.doctorId,
    required this.appointmentDate,
    required this.status,
    required this.purpose,
    required this.location,
    required this.notes,
    required this.reminder,
  });

  Map<String, dynamic> toJson() {
    return {
      'appointmentId': appointmentId,
      'userId': userId,
      'doctorId': doctorId,
      'appointmentDate': appointmentDate.toIso8601String(),
      'status': status,
      'purpose': purpose,
      'location': location,
      'notes': notes,
      'reminder': reminder,
    };
  }

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      appointmentId: json['appointmentId'],
      userId: json['userId'],
      doctorId: json['doctorId'],
      appointmentDate: DateTime.parse(json['appointmentDate']),
      status: json['status'],
      purpose: json['purpose'],
      location: json['location'],
      notes: json['notes'],
      reminder: json['reminder'],
    );
  }
}