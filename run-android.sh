#!/bin/bash

echo "🚀 Starting Care for Elders App on Android Emulator..."
echo ""

cd /Users/chamindu/Documents/GitHub/care-for-elders

# Check if emulator is running
if ! adb devices | grep -q "emulator"; then
    echo "❌ No Android emulator detected"
    echo ""
    echo "Please start your emulator first:"
    echo "  - Open Android Studio"
    echo "  - Go to Tools > Device Manager"
    echo "  - Click the play button on Pixel 7 API 36"
    echo ""
    exit 1
fi

echo "✅ Emulator detected"
echo ""
echo "🔨 Building and launching app..."
echo ""

# Run the app
flutter run -d emulator-5554 --verbose


