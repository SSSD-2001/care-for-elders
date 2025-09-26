import 'package:flutter/material.dart';
import 'models/Activity.dart';
import 'models/Appointment.dart';
import 'models/CommunicationHub.dart';
import 'models/Diagnosis.dart';
import 'models/Doctor.dart';
import 'models/EmergencyContact.dart';
import 'models/EmergencyService.dart';
import 'models/HealthTip.dart';
import 'models/HealthTracking.dart';
import 'models/MedicalRecord.dart';
import 'models/Medication.dart';
import 'models/MedicationReminder.dart';
import 'models/Message.dart';
import 'models/Notification.dart' as app_notification;
import 'models/Prescription.dart';
import 'models/TestResults.dart';
import 'models/VitalSign.dart';
import 'models/WellnessGoal.dart';
import 'models/User.dart';
import 'utils/logger.dart';

void main() {
  AppLogger.setupLogger();

  // ---------------- USER ----------------
  var user = User(
    userId: 'u1',
    name: 'Senumi',
    email: 'senumi@example.com',
    password: '12345',
    phoneNumber: '+94123456789',
    dateOfBirth: DateTime(2000, 1, 1),
    address: 'Colombo',
    emergencyContacts: ['Alice', 'Bob'],
    bloodType: 'O+',
    allergies: ['Pollen'],
    role: 'Elder',
  );

  AppLogger.info("👤 User: ${user.name}");

  // Try register
  user.register("newuser@example.com", "pass123");

  // Try login
  AppLogger.info(
    user.login("newuser@example.com", "pass123")
        ? "✅ Login successful"
        : "❌ Login failed",
  );

  // Update profile
  user.updateProfile("New Senumi", "newsenumi@example.com");

  // Share health data
  user.shareHealthData(101);

  // Trigger SOS
  user.triggerSOS();

  // ---------------- EMERGENCY CONTACT ----------------
  var contact = Emergencycontact(
    contactId: 'c1',
    userId: 'u1',
    name: 'Alice',
    phoneNumber: '+94123456789',
    relationship: 'Friend',
    priority: 1,
    isNotified: false,
  );

  AppLogger.info(contact.getContactInfo());
  // 👤 Alice (Friend), 📞 +94123456789, Priority: 1

  contact.notifyEmergency();
  // 🚨 Emergency! Notifying Alice at +94123456789
  AppLogger.info("Is notified? ${contact.isNotified}");
  // Is notified? true

  // ---------------- MEDICAL RECORD ----------------
  var record = MedicalRecord(
    recordId: 1,
    userId: 101,
    title: "General Checkup",
    date: DateTime.now(),
    description: "Routine health check",
    perscriptions: [],
    fileUrl: "http://example.com/file.pdf",
    testResults: [],
    category: "General",
    diagnosis: [],
  );

  record.addPrescription("Paracetamol 500mg");
  record.addTestResult("Blood Test - Normal");
  record.addDiagnosis("Mild fever");

  AppLogger.info(record.getMedicalRecords().toString());
  // [Prescriptions: Paracetamol 500mg, Test Results: Blood Test - Normal, Diagnosis: Mild fever]

  record.deleteRecord();
  // 🗑️ All medical record details deleted.

  // ---------------- APPOINTMENT ----------------
  var appointment = Appointment(
    appointmentId: "A101",
    userId: "U1",
    doctorId: 2001,
    appointmentDate: DateTime.now().add(Duration(days: 3)),
    status: "Pending",
    purpose: "Routine Checkup",
    location: "City Hospital",
    notes: "Bring previous reports",
    reminder: false,
  );

  appointment.scheduleAppointment();
  appointment.setReminder(true);
  AppLogger.info(appointment.getAppointmentDetails());
  appointment.cancelAppointment();

  // ---------------- DOCTOR ----------------
  var doctor = Doctor(
    doctorId: 2001,
    name: "Sarah Johnson",
    speciality: "Cardiologist",
    contactInfo: "+94123456789",
    hospital: "City Hospital",
  );

  AppLogger.info(doctor.getDoctorDetails());
  // 👨‍⚕️ Dr. Sarah Johnson (Cardiologist)
  // 🏥 Hospital: City Hospital
  // 📞 Contact: +94123456789

  doctor.scheduleAppointment(DateTime.now().add(Duration(days: 2)));
  // 📅 Appointment scheduled with Dr. Sarah Johnson (Cardiologist) at City Hospital on 2025-09-26 ...

  // ---------------- MEDICATION & REMINDER ----------------
  var med = Medication(
    medicationId: "M1",
    userId: "U1",
    name: "Paracetamol",
    dosage: "500mg",
    frequency: "Twice a day",
    startDate: DateTime.now(),
    endDate: DateTime.now().add(Duration(days: 7)),
    instructions: "Take after meals",
    remainingQuantity: 5,
  );

  med.createReminder();
  med.markAsTaken();
  med.refillAlert();

  var reminder = MedicationReminder(
    id: 1,
    prescriptionId: 101,
    date: DateTime.now(),
  );
  reminder.setReminder(DateTime.now().add(Duration(hours: 6)));
  reminder.cancelReminder();

  // ---------------- VITAL SIGN & ACTIVITY ----------------
  var bp = VitalSign(
    id: 1,
    type: "Blood Pressure",
    value: "120/80",
    date: DateTime.now(),
  );
  bp.updateValue("130/85");
  // 🩺 Vital sign 'Blood Pressure' updated to 130/85 at 2025-09-24 ...

  var walk = Activity(
    id: 1,
    type: "Walking",
    duration: 30,
    date: DateTime.now(),
  );
  walk.updateDuration(45);
  // 🏃 Activity 'Walking' duration updated to 45 mins at 2025-09-24 ...

  // ---------------- WELLNESS GOAL & HEALTH TIP ----------------
  var goal = WellnessGoal(
    id: 1,
    userId: "U1",
    goalDescription: "Walk 10,000 steps daily",
    targetValue: "10000 steps",
    progress: "20%",
  );

  goal.setGoal("Lose weight", "5kg in 2 months");
  goal.updateProgress("40%");

  var tip = Healthtip(
    id: 1,
    title: "Stay Hydrated",
    content: "Drink at least 8 glasses of water daily.",
  );
  AppLogger.info(tip.getTip());
  // 💡 Stay Hydrated: Drink at least 8 glasses of water daily.

  // ---------------- NOTIFICATION & MESSAGE ----------------
  var n1 = app_notification.Notification(
    notificationId: "N1",
    userId: "U1",
    message: "Your appointment is tomorrow",
    title: "Appointment Reminder",
    type: "Reminder",
    dateTime: DateTime.now(),
    isRead: false,
  );

  var n2 = app_notification.Notification(
    notificationId: "N2",
    userId: "U1",
    message: "Take your medicine",
    title: "Medication Alert",
    type: "Alert",
    dateTime: DateTime.now(),
    isRead: false,
  );

  n1.sendNotification();
  n1.markAsRead();

  AppLogger.info(
    "🔔 Unread count: ${app_notification.Notification.getUnreadCount([n1, n2])}",
  );
  // 🔔 Unread count: 1

  var msg = Message(
    id: 101,
    fromUserId: 1,
    toUserId: 2,
    content: "Hello, how are you?",
    timestamp: DateTime.now(),
  );

  AppLogger.info(msg.getMessageDetails());
  // 📩 Message from User 1 to User 2
  // 🕒 2025-09-24...
  // Content: Hello, how are you?

  // ---------------- EMERGENCY SERVICE & HEALTH TRACKING ----------------
  var fireService = EmergencyService(
    serviceId: "ES1",
    name: "Colombo Fire Department",
    phoneNumber: "110",
    address: "Main Street, Colombo",
    dserviceType: "Fire",
  );

  fireService.callEmergencyService();
  fireService.getDirections();

  var tracker = HealthTracking(
    userId: "U1",
    trackerId: "T1",
    type: "Daily Health",
    date: DateTime.now(),
    vitalSigns: [],
    value: 75.0,
    unit: "kg",
    activityLog: [],
  );

  tracker.logVitalSign(
    VitalSign(id: 1, type: "BP", value: "120/80", date: DateTime.now()),
  );
  tracker.logActivity(
    Activity(id: 1, type: "Running", duration: 30, date: DateTime.now()),
  );
  tracker.generateReport();

  var diag = Diagnosis(
    id: 1,
    description: "Flu symptoms",
    date: DateTime.now(),
  );
  diag.updateDescription("Recovered from flu");

  // ---------------- PRESCRIPTION ---------------

  var pres = Prescription(
    id: 1,
    medicationName: "Amoxicillin",
    dosage: "250mg",
    frequency: "3 times a day",
    startDate: DateTime.now(),
    endDate: DateTime.now().add(Duration(days: 7)),
  );

  pres.updateDosage("500mg");
  pres.setReminder(DateTime.now().add(Duration(hours: 6)));

  var test = TestResults(
    id: 1,
    testName: "Blood Sugar",
    resultValue: "90 mg/dL",
    date: DateTime.now(),
  );
  test.updateResult("95 mg/dL");

  var hub = CommunicationHub(id: 1, userId: 101, messages: []);
  hub.sendMessage(202, "Hello, Doctor. I need advice.");
  AppLogger.info(hub.getMessages().toString());

  // Start the Flutter app
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Care for Elders',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(title: 'Care for Elders Home'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome to Care for Elders',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: 20),
            Text(
              'A comprehensive healthcare app for elderly care.',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
