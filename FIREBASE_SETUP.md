# Firebase Backend Setup Guide

## Overview
Your "Care for Elders" app is now connected to Firebase! This guide explains what has been set up and how to configure Firebase console.

## ✅ What's Been Configured

### 1. **iOS Setup** ✓
- Created `Podfile` with iOS 13.0 deployment target
- Configured Firebase pods
- Successfully installed CocoaPods dependencies

### 2. **Android Setup** ✓
- Google Services plugin configured in `build.gradle.kts`
- Firebase dependencies properly set up

### 3. **Flutter Dependencies** ✓
Added to `pubspec.yaml`:
- `firebase_core`: ^2.24.2 - Core Firebase functionality
- `firebase_auth`: ^4.15.3 - User authentication
- `cloud_firestore`: ^4.13.6 - Database
- `firebase_storage`: ^11.5.6 - File storage

### 4. **Code Integration** ✓
- **AuthService**: Updated to use Firebase Authentication
- **FirestoreService**: Created for database operations
- **User Model**: Enhanced with Firestore serialization
- **main.dart**: Firebase initialized on app startup

## 🚀 Firebase Console Setup

### Step 1: Create Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Add Project"
3. Enter project name: `care-for-elders`
4. Enable Google Analytics (optional)
5. Click "Create Project"

### Step 2: Register Your Apps

#### For iOS:
1. In Firebase Console, click the iOS icon
2. Enter iOS bundle ID: `com.example.care_for_elders` (or your custom bundle ID)
3. Download `GoogleService-Info.plist`
4. Place it in: `ios/Runner/GoogleService-Info.plist`

#### For Android:
1. In Firebase Console, click the Android icon
2. Enter package name: `com.example.care_for_elders`
3. Download `google-services.json`
4. Place it in: `android/app/google-services.json`

### Step 3: Generate Firebase Config Files

Run this command in your project root:
```bash
dart pub global activate flutterfire_cli
flutterfire configure
```

This will:
- Automatically detect your Firebase project
- Generate `lib/firebase_options.dart`
- Configure iOS and Android apps

### Step 4: Enable Authentication

1. In Firebase Console, go to **Authentication**
2. Click "Get Started"
3. Enable **Email/Password** authentication:
   - Click on "Email/Password"
   - Toggle "Enable"
   - Click "Save"

### Step 5: Create Firestore Database

1. In Firebase Console, go to **Firestore Database**
2. Click "Create Database"
3. Choose **Start in test mode** (for development)
4. Select your region (closest to you)
5. Click "Enable"

#### Security Rules (Test Mode):
```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /{document=**} {
      allow read, write: if request.time < timestamp.date(2025, 2, 1);
    }
  }
}
```

#### Production Security Rules:
```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Users can only read/write their own data
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
      
      // Subcollections
      match /{subcollection}/{document=**} {
        allow read, write: if request.auth != null && request.auth.uid == userId;
      }
    }
  }
}
```

### Step 6: Enable Firebase Storage (Optional)

1. In Firebase Console, go to **Storage**
2. Click "Get Started"
3. Start in **test mode**
4. Click "Done"

## 📁 Firestore Database Structure

Your app uses this database structure:

```
users (collection)
  └── {userId} (document)
      ├── userId: string
      ├── name: string
      ├── email: string
      ├── phoneNumber: string
      ├── dateOfBirth: string (ISO 8601)
      ├── address: string
      ├── bloodType: string
      ├── role: string
      ├── emergencyContacts: array
      ├── allergies: array
      │
      ├── health_tracking (subcollection)
      │   └── {recordId}
      │       ├── timestamp: timestamp
      │       ├── bloodPressure: map
      │       ├── heartRate: number
      │       └── ...
      │
      ├── medications (subcollection)
      │   └── {medicationId}
      │       ├── name: string
      │       ├── dosage: string
      │       ├── frequency: string
      │       └── ...
      │
      ├── appointments (subcollection)
      │   └── {appointmentId}
      │       ├── dateTime: timestamp
      │       ├── doctorName: string
      │       ├── location: string
      │       └── ...
      │
      ├── emergency_contacts (subcollection)
      │   └── {contactId}
      │       ├── name: string
      │       ├── phoneNumber: string
      │       └── relationship: string
      │
      └── medical_records (subcollection)
          └── {recordId}
              ├── date: timestamp
              ├── type: string
              ├── fileUrl: string
              └── ...
```

## 🔧 Using Firebase Services

### Authentication Examples

#### Register a new user:
```dart
final authService = AuthService();
bool success = await authService.register(
  name: 'John Doe',
  email: 'john@example.com',
  password: 'password123',
  phoneNumber: '+1234567890',
  dateOfBirth: DateTime(1950, 1, 1),
);
```

#### Login:
```dart
bool success = await authService.login(
  'john@example.com',
  'password123',
);
```

#### Logout:
```dart
await authService.logout();
```

### Firestore Examples

#### Add Health Tracking Data:
```dart
final firestoreService = FirestoreService();
await firestoreService.addHealthTracking(
  userId,
  {
    'timestamp': Timestamp.now(),
    'bloodPressure': {'systolic': 120, 'diastolic': 80},
    'heartRate': 72,
    'weight': 70.5,
  },
);
```

#### Get Medications Stream:
```dart
Stream<QuerySnapshot> medications = 
    firestoreService.getMedicationsStream(userId);
```

#### Add Appointment:
```dart
await firestoreService.addAppointment(
  userId,
  {
    'doctorName': 'Dr. Smith',
    'dateTime': Timestamp.fromDate(appointmentDate),
    'location': 'City Hospital',
    'notes': 'Regular checkup',
  },
);
```

## 🧪 Testing Firebase Connection

Run your app to test:

```bash
flutter run
```

Check the logs for:
- ✅ "Firebase initialized successfully"
- ✅ "User registered successfully"
- ✅ "User logged in"

## ⚠️ Important Notes

### url_launcher Issue
The `url_launcher` package was temporarily commented out due to iOS deployment target conflicts. To re-enable:

1. Update iOS deployment target to 18.0 in `Podfile`
2. Uncomment in `pubspec.yaml`:
   ```yaml
   url_launcher: ^6.3.1
   ```
3. Run: `flutter pub get && cd ios && pod install`

### Security Best Practices

1. **Never commit sensitive files:**
   - `google-services.json`
   - `GoogleService-Info.plist`
   - Add them to `.gitignore`

2. **Update Firestore rules** before production

3. **Enable App Check** for additional security

4. **Use environment variables** for API keys

## 📱 Running the App

### iOS:
```bash
flutter run -d ios
```

### Android:
```bash
flutter run -d android
```

### Rebuild after changes:
```bash
flutter clean
flutter pub get
cd ios && pod install
cd ..
flutter run
```

## 🐛 Troubleshooting

### Issue: "Firebase not initialized"
**Solution**: Make sure `flutterfire configure` was run and `firebase_options.dart` exists.

### Issue: "Pod install failed"
**Solution**: 
```bash
cd ios
rm -rf Pods Podfile.lock
pod repo update
pod install
```

### Issue: "Authentication failed"
**Solution**: Check that Email/Password auth is enabled in Firebase Console.

### Issue: "Permission denied" in Firestore
**Solution**: Update Firestore security rules to allow access.

## 📚 Next Steps

1. ✅ Set up Firebase Console (follow steps above)
2. ✅ Run `flutterfire configure`
3. ✅ Enable Authentication
4. ✅ Create Firestore Database
5. 🔲 Test user registration and login
6. 🔲 Implement remaining screens
7. 🔲 Add data validation
8. 🔲 Set up Firebase Cloud Messaging for notifications
9. 🔲 Configure production security rules
10. 🔲 Deploy to App Store / Play Store

## 📞 Need Help?

- [Firebase Documentation](https://firebase.google.com/docs)
- [FlutterFire Documentation](https://firebase.flutter.dev/)
- [Flutter Firebase Codelab](https://firebase.google.com/codelabs/firebase-get-to-know-flutter)

## ✨ What's Working Now

- ✅ Firebase initialization in main.dart
- ✅ User authentication (register, login, logout)
- ✅ Firestore database service
- ✅ User data persistence
- ✅ Password reset functionality
- ✅ Profile updates synced to Firestore
- ✅ iOS and Android configuration ready

Happy coding! 🚀

