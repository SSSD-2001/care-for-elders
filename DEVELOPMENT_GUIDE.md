# Development Guide - Care for Elders App

This guide will help you continue development on the Care for Elders app.

## Current Implementation Status

### ✅ Completed
- Authentication flow (Login, Register, Splash)
- App navigation with bottom tabs
- Dashboard with quick actions
- All main tab screens (Appointments, Medications, Health Tracking, Emergency)
- Profile screen
- Basic state management with Provider
- UI components and styling
- Data models (19 models ready to use)

### 🚧 In Progress / Todo
- Backend integration
- CRUD operations for all features
- Local notifications
- Data persistence
- Form screens for data entry

## Step-by-Step Implementation Guide

### Phase 1: Database Setup (Week 1)

#### Option 1: Use Hive (Local First)

1. **Initialize Hive in main.dart**
```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Hive
  await Hive.initFlutter();
  
  // Register adapters (you'll need to create these)
  Hive.registerAdapter(AppointmentAdapter());
  Hive.registerAdapter(MedicationAdapter());
  
  // Open boxes
  await Hive.openBox<Appointment>('appointments');
  await Hive.openBox<Medication>('medications');
  
  AppLogger.setupLogger();
  runApp(const MyApp());
}
```

2. **Make models Hive-compatible**

Add to your model files:
```dart
import 'package:hive/hive.dart';

part 'Appointment.g.dart';  // Generated file

@HiveType(typeId: 0)
class Appointment {
  @HiveField(0)
  String appointmentId;
  
  @HiveField(1)
  String userId;
  
  // ... rest of fields with @HiveField annotations
}
```

3. **Generate adapters**
```bash
flutter packages pub run build_runner build
```

#### Option 2: Use Firebase

1. **Add Firebase to your project**
```bash
flutter pub add firebase_core firebase_auth cloud_firestore
flutterfire configure
```

2. **Initialize Firebase in main.dart**
```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
```

### Phase 2: Services Layer (Week 1-2)

Create service files for each feature:

#### Example: AppointmentService

```dart
// lib/services/appointment_service.dart
import 'package:hive/hive.dart';
import '../models/Appointment.dart';

class AppointmentService {
  static final AppointmentService _instance = AppointmentService._internal();
  factory AppointmentService() => _instance;
  AppointmentService._internal();
  
  late Box<Appointment> _box;
  
  Future<void> initialize() async {
    _box = await Hive.openBox<Appointment>('appointments');
  }
  
  // Get all appointments for user
  List<Appointment> getAppointments(String userId) {
    return _box.values
        .where((apt) => apt.userId == userId)
        .toList()
        ..sort((a, b) => a.appointmentDate.compareTo(b.appointmentDate));
  }
  
  // Get upcoming appointments
  List<Appointment> getUpcomingAppointments(String userId) {
    final now = DateTime.now();
    return getAppointments(userId)
        .where((apt) => apt.appointmentDate.isAfter(now))
        .toList();
  }
  
  // Add appointment
  Future<void> addAppointment(Appointment appointment) async {
    await _box.put(appointment.appointmentId, appointment);
  }
  
  // Update appointment
  Future<void> updateAppointment(Appointment appointment) async {
    await _box.put(appointment.appointmentId, appointment);
  }
  
  // Delete appointment
  Future<void> deleteAppointment(String appointmentId) async {
    await _box.delete(appointmentId);
  }
  
  // Cancel appointment
  Future<void> cancelAppointment(String appointmentId) async {
    final appointment = _box.get(appointmentId);
    if (appointment != null) {
      appointment.status = 'Cancelled';
      await _box.put(appointmentId, appointment);
    }
  }
}
```

Create similar services for:
- `medication_service.dart`
- `health_tracking_service.dart`
- `emergency_contact_service.dart`
- `vital_sign_service.dart`

### Phase 3: Providers (Week 2)

Create providers for each feature:

```dart
// lib/providers/appointment_provider.dart
import 'package:flutter/foundation.dart';
import '../models/Appointment.dart';
import '../services/appointment_service.dart';
import '../services/auth_service.dart';

class AppointmentProvider extends ChangeNotifier {
  final AppointmentService _service = AppointmentService();
  final AuthService _authService = AuthService();
  
  List<Appointment> _appointments = [];
  bool _isLoading = false;
  String? _error;
  
  List<Appointment> get appointments => _appointments;
  bool get isLoading => _isLoading;
  String? get error => _error;
  
  List<Appointment> get upcomingAppointments => _appointments
      .where((apt) => apt.appointmentDate.isAfter(DateTime.now()))
      .toList();
  
  List<Appointment> get pastAppointments => _appointments
      .where((apt) => apt.appointmentDate.isBefore(DateTime.now()))
      .toList();
  
  Future<void> loadAppointments() async {
    if (_authService.currentUser == null) return;
    
    _isLoading = true;
    _error = null;
    notifyListeners();
    
    try {
      _appointments = _service.getAppointments(_authService.currentUser!.userId);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = 'Failed to load appointments: $e';
      _isLoading = false;
      notifyListeners();
    }
  }
  
  Future<bool> addAppointment(Appointment appointment) async {
    try {
      await _service.addAppointment(appointment);
      await loadAppointments();
      return true;
    } catch (e) {
      _error = 'Failed to add appointment: $e';
      notifyListeners();
      return false;
    }
  }
  
  Future<bool> updateAppointment(Appointment appointment) async {
    try {
      await _service.updateAppointment(appointment);
      await loadAppointments();
      return true;
    } catch (e) {
      _error = 'Failed to update appointment: $e';
      notifyListeners();
      return false;
    }
  }
  
  Future<bool> cancelAppointment(String appointmentId) async {
    try {
      await _service.cancelAppointment(appointmentId);
      await loadAppointments();
      return true;
    } catch (e) {
      _error = 'Failed to cancel appointment: $e';
      notifyListeners();
      return false;
    }
  }
  
  void clearError() {
    _error = null;
    notifyListeners();
  }
}
```

### Phase 4: Form Screens (Week 3)

Create form screens for data entry:

```dart
// lib/screens/appointments/appointment_form_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../constants/app_constants.dart';
import '../../models/Appointment.dart';
import '../../providers/appointment_provider.dart';
import '../../providers/auth_provider.dart';

class AppointmentFormScreen extends StatefulWidget {
  final Appointment? appointment; // null for new, existing for edit
  
  const AppointmentFormScreen({Key? key, this.appointment}) : super(key: key);

  @override
  State<AppointmentFormScreen> createState() => _AppointmentFormScreenState();
}

class _AppointmentFormScreenState extends State<AppointmentFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _purposeController;
  late TextEditingController _locationController;
  late TextEditingController _notesController;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  
  @override
  void initState() {
    super.initState();
    _purposeController = TextEditingController(
      text: widget.appointment?.purpose ?? '',
    );
    _locationController = TextEditingController(
      text: widget.appointment?.location ?? '',
    );
    _notesController = TextEditingController(
      text: widget.appointment?.notes ?? '',
    );
    _selectedDate = widget.appointment?.appointmentDate;
  }
  
  @override
  void dispose() {
    _purposeController.dispose();
    _locationController.dispose();
    _notesController.dispose();
    super.dispose();
  }
  
  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }
  
  Future<void> _selectTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() => _selectedTime = picked);
    }
  }
  
  Future<void> _saveAppointment() async {
    if (!_formKey.currentState!.validate()) return;
    
    if (_selectedDate == null || _selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select date and time')),
      );
      return;
    }
    
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final appointmentProvider = Provider.of<AppointmentProvider>(
      context,
      listen: false,
    );
    
    final appointmentDate = DateTime(
      _selectedDate!.year,
      _selectedDate!.month,
      _selectedDate!.day,
      _selectedTime!.hour,
      _selectedTime!.minute,
    );
    
    final appointment = Appointment(
      appointmentId: widget.appointment?.appointmentId ?? 
          'apt_${DateTime.now().millisecondsSinceEpoch}',
      userId: authProvider.currentUser!.userId,
      doctorId: 0, // TODO: Add doctor selection
      appointmentDate: appointmentDate,
      status: 'Scheduled',
      purpose: _purposeController.text,
      location: _locationController.text,
      notes: _notesController.text,
      reminder: true,
    );
    
    final success = widget.appointment == null
        ? await appointmentProvider.addAppointment(appointment)
        : await appointmentProvider.updateAppointment(appointment);
    
    if (success && mounted) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            widget.appointment == null
                ? 'Appointment added successfully'
                : 'Appointment updated successfully',
          ),
        ),
      );
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.appointment == null ? 'New Appointment' : 'Edit Appointment',
        ),
        backgroundColor: AppColors.appointmentColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppStyles.paddingMedium),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Date selector
              Card(
                child: ListTile(
                  leading: Icon(Icons.calendar_today),
                  title: Text('Date'),
                  subtitle: Text(
                    _selectedDate == null
                        ? 'Select date'
                        : DateFormat('MMM dd, yyyy').format(_selectedDate!),
                  ),
                  onTap: _selectDate,
                ),
              ),
              SizedBox(height: 16),
              
              // Time selector
              Card(
                child: ListTile(
                  leading: Icon(Icons.access_time),
                  title: Text('Time'),
                  subtitle: Text(
                    _selectedTime == null
                        ? 'Select time'
                        : _selectedTime!.format(context),
                  ),
                  onTap: _selectTime,
                ),
              ),
              SizedBox(height: 16),
              
              // Purpose field
              TextFormField(
                controller: _purposeController,
                decoration: InputDecoration(
                  labelText: 'Purpose',
                  prefixIcon: Icon(Icons.medical_services),
                ),
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Please enter purpose' : null,
              ),
              SizedBox(height: 16),
              
              // Location field
              TextFormField(
                controller: _locationController,
                decoration: InputDecoration(
                  labelText: 'Location',
                  prefixIcon: Icon(Icons.location_on),
                ),
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Please enter location' : null,
              ),
              SizedBox(height: 16),
              
              // Notes field
              TextFormField(
                controller: _notesController,
                decoration: InputDecoration(
                  labelText: 'Notes (optional)',
                  prefixIcon: Icon(Icons.note),
                ),
                maxLines: 3,
              ),
              SizedBox(height: 24),
              
              // Save button
              ElevatedButton(
                onPressed: _saveAppointment,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.appointmentColor,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  widget.appointment == null
                      ? 'Add Appointment'
                      : 'Update Appointment',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

### Phase 5: Integrate Providers and Services (Week 3)

1. **Update main.dart to include all providers**

```dart
return MultiProvider(
  providers: [
    ChangeNotifierProvider(create: (_) => AuthProvider()),
    ChangeNotifierProvider(create: (_) => AppointmentProvider()),
    ChangeNotifierProvider(create: (_) => MedicationProvider()),
    ChangeNotifierProvider(create: (_) => HealthTrackingProvider()),
    // Add more providers
  ],
  child: MaterialApp(
    // ... rest of app
  ),
);
```

2. **Update tab screens to use providers**

```dart
// In appointments_tab.dart
class AppointmentsTab extends StatefulWidget {
  const AppointmentsTab({Key? key}) : super(key: key);

  @override
  State<AppointmentsTab> createState() => _AppointmentsTabState();
}

class _AppointmentsTabState extends State<AppointmentsTab> {
  @override
  void initState() {
    super.initState();
    // Load appointments when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AppointmentProvider>(context, listen: false)
          .loadAppointments();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointments'),
        backgroundColor: AppColors.appointmentColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => AppointmentFormScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Consumer<AppointmentProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }
          
          if (provider.error != null) {
            return Center(child: Text('Error: ${provider.error}'));
          }
          
          if (provider.upcomingAppointments.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.calendar_today, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text('No upcoming appointments'),
                ],
              ),
            );
          }
          
          return ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: provider.upcomingAppointments.length,
            itemBuilder: (context, index) {
              final apt = provider.upcomingAppointments[index];
              return _buildAppointmentCard(context, apt, provider);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => AppointmentFormScreen()),
          );
        },
        backgroundColor: AppColors.appointmentColor,
        child: Icon(Icons.add),
      ),
    );
  }
  
  Widget _buildAppointmentCard(
    BuildContext context,
    Appointment appointment,
    AppointmentProvider provider,
  ) {
    // Build card UI using real data
    // ... (use existing card design but with real appointment data)
  }
}
```

### Phase 6: Notifications (Week 4)

```dart
// lib/services/notification_service.dart
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();
  
  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();
  
  Future<void> initialize() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings();
    
    const settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );
    
    await _notifications.initialize(settings);
  }
  
  Future<void> scheduleMedicationReminder(
    String id,
    String medicationName,
    DateTime scheduledTime,
  ) async {
    await _notifications.zonedSchedule(
      id.hashCode,
      'Medication Reminder',
      'Time to take $medicationName',
      tz.TZDateTime.from(scheduledTime, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'medication_channel',
          'Medication Reminders',
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }
}
```

## Testing Your Implementation

After implementing each phase:

1. **Test on emulator/device**
```bash
flutter run
```

2. **Check for errors**
```bash
flutter analyze
```

3. **Run tests**
```bash
flutter test
```

## Common Issues and Solutions

### Issue: Hive boxes not opening
**Solution**: Make sure to initialize Hive before opening boxes and register adapters.

### Issue: Provider not updating UI
**Solution**: Always call `notifyListeners()` after state changes in providers.

### Issue: DateTime serialization errors
**Solution**: Convert DateTime to ISO8601 string when storing, parse back when reading.

### Issue: Notifications not showing
**Solution**: Request permissions and ensure notification channel is properly configured.

## Performance Tips

1. Use `const` constructors where possible
2. Implement pagination for large lists
3. Use `ListView.builder` instead of `ListView` for long lists
4. Cache images and data
5. Minimize rebuilds using `Consumer` widgets strategically

## Security Best Practices

1. Never store passwords in plain text
2. Use secure storage for sensitive data
3. Validate all user inputs
4. Implement proper error handling
5. Use HTTPS for all network calls

## Next Steps After Implementation

1. Add unit tests
2. Add integration tests
3. Perform security audit
4. Optimize performance
5. Add analytics
6. Prepare for production deployment
7. Create app store listings
8. Set up crash reporting (Firebase Crashlytics)

Good luck with your development! 🚀

