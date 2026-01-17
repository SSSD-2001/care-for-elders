# Backend Setup and Integration Guide

## ✅ Backend Created Successfully!

Your Node.js/Express backend is ready at:
`c:\Users\HP\Documents\GitHub\care-for-elders-backend`

## 🚀 Quick Start Guide

### Step 1: Install MongoDB

**Option A: Local MongoDB (Recommended for Development)**
1. Download MongoDB Community Server: https://www.mongodb.com/try/download/community
2. Install and start MongoDB service
3. MongoDB will run on: `mongodb://localhost:27017`

**Option B: MongoDB Atlas (Cloud - Free)**
1. Create account at: https://www.mongodb.com/cloud/atlas
2. Create a free cluster
3. Get connection string
4. Update `.env` file in backend folder

### Step 2: Install Backend Dependencies

```bash
cd c:\Users\HP\Documents\GitHub\care-for-elders-backend
npm install
```

### Step 3: Start the Backend Server

```bash
npm run dev
```

You should see:
```
✅ Connected to MongoDB
🚀 Server running on port 3000
```

### Step 4: Test the Backend

Open browser and visit: http://localhost:3000
You should see: `{"message": "Care for Elders API is running!"}`

### Step 5: Update Flutter App

The Flutter app is already configured to connect to your backend!

**API Services created:**
- ✅ `api_auth_service.dart` - Authentication
- ✅ `api_appointment_service.dart` - Appointments
- ✅ `api_medication_service.dart` - Medications
- ✅ `api_health_service.dart` - Health records

**To use the API instead of local storage:**

Replace the existing `AuthService` usage with `ApiAuthService` in your app.

### Step 6: Run Flutter App

```bash
cd c:\Users\HP\Documents\GitHub\care-for-elders
flutter pub get
flutter run -d windows
```

## 📱 How to Switch to API Backend

### Update Login Screen

In `lib/screens/auth/login_screen.dart`, replace:
```dart
import '../services/auth_service.dart';
final authService = AuthService();
```

With:
```dart
import '../services/api_auth_service.dart';
final authService = ApiAuthService();
```

### Important Notes

1. **Backend URL**: The Flutter app is configured to connect to `http://localhost:3000`
   - This works for Windows desktop app
   - For mobile/web, you may need to use your computer's IP address

2. **CORS**: Already configured in backend to allow all origins during development

3. **Authentication**: Uses JWT tokens stored in SharedPreferences

## 🗂️ Backend Structure

```
care-for-elders-backend/
├── server.js                 # Main server file
├── .env                      # Environment variables
├── package.json              # Dependencies
├── models/
│   ├── User.js              # User model
│   ├── Appointment.js       # Appointment model
│   ├── Medication.js        # Medication model
│   └── HealthRecord.js      # Health record model
├── routes/
│   ├── auth.js              # Auth endpoints
│   ├── appointments.js      # Appointment endpoints
│   ├── medications.js       # Medication endpoints
│   ├── health.js            # Health endpoints
│   └── emergency.js         # Emergency endpoints
└── middleware/
    └── auth.js              # JWT authentication
```

## 🔑 API Endpoints

### Authentication
- `POST /api/auth/register` - Register new user
- `POST /api/auth/login` - Login user
- `GET /api/auth/me` - Get current user (requires token)

### Appointments
- `GET /api/appointments` - Get all appointments
- `POST /api/appointments` - Create appointment
- `PUT /api/appointments/:id` - Update appointment
- `DELETE /api/appointments/:id` - Delete appointment

### Medications
- `GET /api/medications` - Get all medications
- `POST /api/medications` - Create medication
- `PUT /api/medications/:id` - Update medication
- `DELETE /api/medications/:id` - Delete medication

### Health Records
- `GET /api/health` - Get health records
- `POST /api/health` - Create health record
- `DELETE /api/health/:id` - Delete health record

### Emergency
- `GET /api/emergency/contacts` - Get emergency contacts
- `POST /api/emergency/contacts` - Add emergency contact
- `DELETE /api/emergency/contacts/:contactId` - Delete contact

## 🔧 Troubleshooting

### Backend won't start
- Make sure MongoDB is running
- Check if port 3000 is available
- Run: `npm install` to ensure all dependencies are installed

### Flutter can't connect
- Make sure backend is running on http://localhost:3000
- Check firewall settings
- For mobile devices, use your computer's IP instead of localhost

### MongoDB connection error
- Verify MongoDB is running: `mongod --version`
- Check connection string in `.env` file

## 📝 Next Steps

1. Install MongoDB
2. Run `npm install` in backend folder
3. Start backend with `npm run dev`
4. Test API at http://localhost:3000
5. Update Flutter app to use API services
6. Run Flutter app

Need help with any step? Let me know!
