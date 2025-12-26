# 🏥 Care for Elders - Healthcare App

A comprehensive Flutter mobile application for managing elderly healthcare needs with Firebase backend integration.

## 🚀 Quick Start

**Run the app:**
```bash
# Android Emulator
flutter run

# Chrome (Web)
flutter run -d chrome

# iOS Simulator
flutter run -d ios
```

## 📚 Documentation

- **[DEVELOPMENT_GUIDE.md](DEVELOPMENT_GUIDE.md)** - Development instructions & adding features
- **[FIREBASE_SETUP.md](FIREBASE_SETUP.md)** - Firebase configuration guide
- **[TROUBLESHOOTING.md](TROUBLESHOOTING.md)** - Common issues & solutions
- **[SCREEN_GUIDE.md](SCREEN_GUIDE.md)** - All screens and features overview

## 📱 Features Implemented

### ✅ Authentication System
- User login and registration
- Session management with SharedPreferences
- Splash screen with auto-navigation
- Profile management

### ✅ Dashboard
- Welcome screen with personalized greeting
- Quick action cards for common tasks
- Today's overview with appointments, medications, and health goals
- Health tips section

### ✅ Appointments Management
- View upcoming and past appointments
- Appointment details (doctor, date, location, purpose)
- Quick actions (reschedule, view details)
- Add new appointments (UI ready)

### ✅ Medications Tracking
- Today's medication schedule
- Mark medications as taken
- View all medications with dosage information
- Refill alerts for low stock
- Add new medications (UI ready)

### ✅ Health Tracking
- Vital signs monitoring (Blood Pressure, Heart Rate, Blood Sugar, Temperature)
- Activity logging (Walking, Yoga, etc.)
- Wellness goals with progress tracking
- Visual progress indicators

### ✅ Emergency Features
- Large SOS button for emergencies
- Emergency services (Ambulance, Police, Fire Department) with one-tap calling
- Emergency contacts list with priority
- Medical information display (Blood type, Allergies, Medications, Conditions)

### ✅ Profile Screen
- User information display
- Personal and medical information
- Settings and preferences
- Logout functionality

## 🏗️ Project Structure

```
lib/
├── main.dart                      # App entry point
├── constants/
│   └── app_constants.dart         # Colors, styles, constants
├── models/                        # Data models (19 models)
│   ├── User.dart
│   ├── Appointment.dart
│   ├── Medication.dart
│   └── ... (and more)
├── providers/
│   └── auth_provider.dart         # State management for authentication
├── screens/
│   ├── auth/                      # Authentication screens
│   │   ├── splash_screen.dart
│   │   ├── login_screen.dart
│   │   └── register_screen.dart
│   ├── home/                      # Main app screens
│   │   ├── home_screen.dart       # Bottom navigation
│   │   └── dashboard_tab.dart     # Dashboard
│   ├── appointments/
│   │   └── appointments_tab.dart
│   ├── medications/
│   │   └── medications_tab.dart
│   ├── health_tracking/
│   │   └── health_tracking_tab.dart
│   ├── emergency/
│   │   └── emergency_tab.dart
│   └── profile/
│       └── profile_screen.dart
├── services/
│   └── auth_service.dart          # Authentication logic
└── utils/
    └── logger.dart                # Logging utility
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.9.0 or higher)
- Dart SDK
- Android Studio / Xcode (for iOS)
- A physical device or emulator

### Installation

1. **Clone the repository**
   ```bash
   cd /Users/chamindu/Documents/GitHub/care-for-elders
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Login Credentials (Demo)
For testing, use any email and password with at least 4 characters:
- Email: `test@example.com`
- Password: `1234`

## 📦 Dependencies

### Core Dependencies
- `provider: ^6.1.1` - State management
- `google_fonts: ^6.1.0` - Custom fonts
- `shared_preferences: ^2.2.2` - Local storage
- `hive: ^2.2.3` - NoSQL database
- `intl: ^0.19.0` - Date formatting

### Feature Dependencies
- `flutter_local_notifications: ^17.0.0` - Push notifications
- `url_launcher: ^6.2.2` - Phone calls and URLs
- `permission_handler: ^11.1.0` - App permissions
- `table_calendar: ^3.0.9` - Calendar widget

## 🔨 Next Steps for Development

### 1. Backend Integration
Currently, the app uses dummy data. To make it production-ready:

#### Option A: Firebase (Recommended for MVP)
```bash
# Add Firebase packages
flutter pub add firebase_core firebase_auth cloud_firestore firebase_storage
```

Then:
- Set up Firebase project at [console.firebase.google.com](https://console.firebase.google.com)
- Configure Firebase for Android/iOS
- Replace `AuthService` with Firebase Authentication
- Store data in Cloud Firestore

#### Option B: Custom REST API
- Create services for each feature (AppointmentService, MedicationService, etc.)
- Implement HTTP calls using `http` or `dio` package
- Handle authentication tokens
- Implement error handling and retry logic

### 2. Complete CRUD Operations

Create services for each model:

```dart
// Example: lib/services/appointment_service.dart
class AppointmentService {
  Future<List<Appointment>> getAppointments(String userId) async {
    // Implement API call or local database query
  }
  
  Future<bool> createAppointment(Appointment appointment) async {
    // Implement creation logic
  }
  
  Future<bool> updateAppointment(Appointment appointment) async {
    // Implement update logic
  }
  
  Future<bool> deleteAppointment(String appointmentId) async {
    // Implement deletion logic
  }
}
```

### 3. Implement Notifications

```dart
// lib/services/notification_service.dart
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin _notifications = 
      FlutterLocalNotificationsPlugin();
  
  Future<void> initialize() async {
    // Initialize notification settings
  }
  
  Future<void> scheduleMedicationReminder(
    Medication medication,
    DateTime scheduledTime,
  ) async {
    // Schedule notification
  }
  
  Future<void> scheduleAppointmentReminder(
    Appointment appointment,
    DateTime scheduledTime,
  ) async {
    // Schedule notification
  }
}
```

### 4. Add Form Screens

Create forms to add/edit data:
- `appointment_form_screen.dart` - Add/edit appointments
- `medication_form_screen.dart` - Add/edit medications
- `vital_sign_form_screen.dart` - Log vital signs
- `activity_form_screen.dart` - Log activities

### 5. Implement Data Persistence

Use Hive for local database:

```dart
// lib/services/local_database_service.dart
import 'package:hive_flutter/hive_flutter.dart';

class LocalDatabaseService {
  static Future<void> initialize() async {
    await Hive.initFlutter();
    // Register adapters for models
    await Hive.openBox('appointments');
    await Hive.openBox('medications');
    // etc.
  }
}
```

### 6. Add Additional Features

#### Charts and Analytics
```bash
flutter pub add fl_chart
```

#### Image Picker (for profile pictures)
```bash
flutter pub add image_picker
```

#### PDF Export (for reports)
```bash
flutter pub add pdf syncfusion_flutter_pdf
```

### 7. Implement Providers

Create providers for each feature:

```dart
// lib/providers/appointment_provider.dart
class AppointmentProvider extends ChangeNotifier {
  List<Appointment> _appointments = [];
  bool _isLoading = false;
  
  List<Appointment> get appointments => _appointments;
  bool get isLoading => _isLoading;
  
  Future<void> loadAppointments() async {
    _isLoading = true;
    notifyListeners();
    
    // Load from service
    _appointments = await AppointmentService().getAppointments(userId);
    
    _isLoading = false;
    notifyListeners();
  }
  
  Future<void> addAppointment(Appointment appointment) async {
    // Add appointment logic
    notifyListeners();
  }
}
```

### 8. Testing

Add tests for your services and providers:

```bash
# Run tests
flutter test
```

### 9. Platform-Specific Configuration

#### Android Permissions (android/app/src/main/AndroidManifest.xml)
```xml
<uses-permission android:name="android.permission.INTERNET"/>
<uses-permission android:name="android.permission.CALL_PHONE"/>
<uses-permission android:name="android.permission.SCHEDULE_EXACT_ALARM"/>
```

#### iOS Permissions (ios/Runner/Info.plist)
```xml
<key>NSPhotoLibraryUsageDescription</key>
<string>We need access to your photo library</string>
<key>NSCameraUsageDescription</key>
<string>We need access to your camera</string>
```

## 🎨 Customization

### Colors
Edit `lib/constants/app_constants.dart`:
```dart
class AppColors {
  static const Color primary = Color(0xFF2196F3);  // Change primary color
  static const Color accent = Color(0xFF03DAC6);    // Change accent color
  // ...
}
```

### Fonts
The app uses Google Fonts (Inter). To change:
```dart
textTheme: GoogleFonts.robotoTextTheme(  // Change to any Google Font
  ThemeData.light().textTheme,
),
```

## 📱 Running on Devices

### Android
```bash
flutter run
```

### iOS
```bash
flutter run -d ios
```

### Web
```bash
flutter run -d chrome
```

## 🐛 Troubleshooting

### Build Issues
```bash
flutter clean
flutter pub get
flutter run
```

### Package Conflicts
```bash
flutter pub upgrade
```

## 📝 TODO List

- [ ] Connect to backend API or Firebase
- [ ] Implement actual authentication with secure password storage
- [ ] Add form screens for creating/editing data
- [ ] Implement local notifications for medication reminders
- [ ] Add calendar view for appointments
- [ ] Implement data charts for health tracking
- [ ] Add profile editing functionality
- [ ] Implement emergency SOS functionality (SMS, calls)
- [ ] Add doctor search and booking functionality
- [ ] Implement chat/messaging with doctors
- [ ] Add report generation and export
- [ ] Implement multi-language support
- [ ] Add dark mode theme
- [ ] Implement offline mode with sync
- [ ] Add unit tests and integration tests
- [ ] Set up CI/CD pipeline

## 📄 License

This project is licensed under the MIT License.

## 👥 Contributors

- Chamindu - Initial Development

## 📞 Support

For support, email support@careforelders.com or open an issue in the repository.

---

**Note**: This is a working prototype with UI and basic navigation. Backend integration and full CRUD operations need to be implemented for production use.

