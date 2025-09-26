import '../utils/logger.dart';

class Doctor {
  int doctorId;
  String name;
  String speciality;
  String contactInfo;
  String hospital;

  Doctor({
    required this.doctorId,
    required this.name,
    required this.speciality,
    required this.contactInfo,
    required this.hospital,
  });

  Map<String, dynamic> toJson() {
    return {
      'doctorId': doctorId,
      'name': name,
      'speciality': speciality,
      'contactInfo': contactInfo,
      'hospital': hospital,
    };
  }

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      doctorId: json['doctorId'],
      name: json['name'],
      speciality: json['speciality'],
      contactInfo: json['contactInfo'],
      hospital: json['hospital'],
    );
  }

  // Method to get doctor details
  String getDoctorDetails() {
    return "Dr. $name - $speciality at $hospital. Contact: $contactInfo";
  }

  // Method to schedule appointment
  void scheduleAppointment(DateTime appointmentDate) {
    // Logic for scheduling appointment would go here
    AppLogger.info(
      "Appointment scheduled with Dr. $name for ${appointmentDate.toString()}",
    );
  }
}
