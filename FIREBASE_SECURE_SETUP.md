# 🔐 Firebase Setup Guide (Secure Configuration)

## ⚠️ Important Security Notice

Firebase configuration files contain sensitive API keys and are **NOT** included in this repository for security reasons. You must set up your own Firebase project and generate these files locally.

## Files You Need to Generate

These files are gitignored and must be created locally:

1. ✅ `lib/firebase_options.dart` - Firebase configuration for Flutter
2. ✅ `android/app/google-services.json` - Android Firebase configuration
3. ✅ `ios/Runner/GoogleService-Info.plist` - iOS Firebase configuration

## 🚀 Quick Setup (Recommended)

### Prerequisites

- Flutter SDK installed
- Firebase account created at https://firebase.google.com
- Dart CLI tools

### Step 1: Create Firebase Project

1. Go to https://console.firebase.google.com
2. Click "Add Project"
3. Enter project name: `care-for-elders` (or your preferred name)
4. Follow the setup wizard
5. Enable Google Analytics (optional)

### Step 2: Install FlutterFire CLI

```bash
# Install FlutterFire CLI globally
dart pub global activate flutterfire_cli

# Verify installation
flutterfire --version
```

### Step 3: Configure Firebase for Your Project

```bash
# Navigate to your project directory
cd /path/to/care-for-elders

# Login to Firebase (if not already logged in)
firebase login

# Configure Firebase for all platforms
flutterfire configure --project=YOUR_PROJECT_ID

# Follow the interactive prompts:
# - Select your Firebase project
# - Select platforms: Android, iOS, Web
# - Confirm the configuration
```

This command will automatically:
- ✅ Generate `lib/firebase_options.dart`
- ✅ Download `android/app/google-services.json`
- ✅ Download `ios/Runner/GoogleService-Info.plist`
- ✅ Update your platform-specific configurations

### Step 4: Verify Configuration

Check that these files were created:

```bash
# Check if files exist
ls -la lib/firebase_options.dart
ls -la android/app/google-services.json
ls -la ios/Runner/GoogleService-Info.plist
```

### Step 5: Set Up API Key Restrictions (IMPORTANT!)

🛡️ **Protect your API keys by adding restrictions:**

1. Go to: https://console.cloud.google.com
2. Select your project
3. Navigate to: **APIs & Services** → **Credentials**
4. For each API key, click to edit and add:

**For Android API Key:**
- Application restrictions: **Android apps**
- Add your package name: `com.example.careForElders`
- Add your SHA-1 certificate fingerprint

**For iOS API Key:**
- Application restrictions: **iOS apps**
- Add your bundle ID: `com.example.careForElders`

**For Web API Key:**
- Application restrictions: **HTTP referrers**
- Add your authorized domains

**API Restrictions (for all keys):**
- Restrict to only the APIs you use:
  - Firebase Authentication
  - Cloud Firestore API
  - Firebase Storage
  - Firebase Cloud Messaging (if using push notifications)

### Step 6: Test Your Configuration

```bash
# Run the app
flutter run

# If there are any Firebase errors, check:
# - Firebase project is properly set up
# - All necessary Firebase services are enabled
# - API keys have correct restrictions
```

## 🔧 Manual Setup (Alternative)

If you prefer to set up manually or the automatic method doesn't work:

### For Android

1. Go to Firebase Console → Project Settings
2. Add an Android app:
   - Package name: `com.example.careForElders`
   - Download `google-services.json`
   - Place it in: `android/app/google-services.json`

### For iOS

1. Go to Firebase Console → Project Settings
2. Add an iOS app:
   - Bundle ID: `com.example.careForElders`
   - Download `GoogleService-Info.plist`
   - Place it in: `ios/Runner/GoogleService-Info.plist`

### For Web & Flutter

1. Get your web app configuration from Firebase Console
2. Manually create `lib/firebase_options.dart` using the template:
   - Copy `lib/firebase_options.dart.template`
   - Rename to `lib/firebase_options.dart`
   - Fill in your actual Firebase credentials

## 📝 Template Files

Template files are provided in this repository:

- `lib/firebase_options.dart.template`
- `android/app/google-services.json.template`

Copy and rename these files, then fill in your actual credentials.

## 🚨 Security Checklist

Before you start development, ensure:

- [ ] Firebase configuration files are NOT committed to Git
- [ ] `.gitignore` properly excludes sensitive files (already configured)
- [ ] API keys have proper restrictions in Google Cloud Console
- [ ] You're using different Firebase projects for dev/staging/production
- [ ] Firebase Security Rules are properly configured
- [ ] You've reviewed Firebase usage quotas

## 🔐 Environment Variables (Advanced)

For CI/CD or production builds, consider using environment variables:

```dart
// lib/config/firebase_config.dart
class FirebaseConfig {
  static String get apiKey => 
    const String.fromEnvironment('FIREBASE_API_KEY', 
      defaultValue: 'your-dev-key');
  
  static String get projectId => 
    const String.fromEnvironment('FIREBASE_PROJECT_ID',
      defaultValue: 'care-for-elders-dev');
}
```

Build with environment variables:

```bash
flutter build apk \
  --dart-define=FIREBASE_API_KEY=your-key \
  --dart-define=FIREBASE_PROJECT_ID=your-project
```

## 🧪 Testing Without Firebase (Optional)

If you want to test the app without Firebase:

1. Comment out Firebase initialization in `lib/main.dart`
2. Use mock data for testing
3. Disable Firebase-dependent features

```dart
// lib/main.dart
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Comment this out for testing without Firebase
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  
  runApp(const MyApp());
}
```

## 📚 Additional Resources

- [FlutterFire Documentation](https://firebase.flutter.dev/)
- [Firebase Console](https://console.firebase.google.com)
- [Google Cloud Console](https://console.cloud.google.com)
- [Firebase Security Best Practices](https://firebase.google.com/docs/projects/learn-more#security-best-practices)

## 🆘 Troubleshooting

### "DefaultFirebaseOptions not found"
- Run `flutterfire configure` to generate the file

### "API key not found" errors
- Check that configuration files are in the correct locations
- Verify files are not empty or corrupted

### Build errors on Android
- Ensure `google-services.json` is in `android/app/` directory
- Check that Android build.gradle includes the Google services plugin

### Build errors on iOS
- Run `cd ios && pod install` to update pods
- Ensure `GoogleService-Info.plist` is added to Xcode project

### API key restrictions causing errors
- Temporarily remove restrictions to test
- Add proper SHA-1 fingerprints for Android
- Ensure bundle IDs match exactly

## 🔄 Updating Configuration

If you need to update Firebase settings:

```bash
# Re-run FlutterFire configuration
flutterfire configure --project=YOUR_PROJECT_ID

# This will regenerate all configuration files
```

## 👥 Team Setup

For team members cloning this repository:

1. Each developer needs their own Firebase project for local development, OR
2. Use a shared development Firebase project (not recommended for security), OR
3. Set up Firebase projects for: dev, staging, production

Share configuration files securely:
- Use a password manager (1Password, LastPass)
- Use secure file sharing (not email!)
- Use environment-based configuration

---

**Last Updated**: December 26, 2025
**Status**: 🔐 Secure configuration enforced

