#!/bin/bash

# Care for Elders - Run Script
# This script helps you run the Flutter app on different platforms

echo "=========================================="
echo "Care for Elders - Flutter App Launcher"
echo "=========================================="
echo ""

# Check Flutter installation
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter is not installed or not in PATH"
    exit 1
fi

echo "✅ Flutter found: $(flutter --version | head -1)"
echo ""

# Check available devices
echo "📱 Checking available devices..."
echo ""
flutter devices
echo ""

# Show options
echo "=========================================="
echo "How would you like to run the app?"
echo "=========================================="
echo ""
echo "1. Run on Chrome (Web) - Recommended if no Xcode"
echo "2. Run on macOS (Desktop) - Requires Xcode"
echo "3. Run on Android Emulator - Requires Android Studio"
echo "4. Run on iOS Simulator - Requires Xcode"
echo "5. Show available devices"
echo "6. Run flutter doctor"
echo "q. Quit"
echo ""

read -p "Enter your choice [1-6, q]: " choice

case $choice in
    1)
        echo ""
        echo "🌐 Launching on Chrome..."
        flutter run -d chrome
        ;;
    2)
        echo ""
        echo "🖥️  Launching on macOS..."
        flutter run -d macos
        ;;
    3)
        echo ""
        echo "🤖 Launching on Android..."
        flutter run -d android
        ;;
    4)
        echo ""
        echo "📱 Launching on iOS Simulator..."
        flutter run -d ios
        ;;
    5)
        echo ""
        flutter devices -v
        ;;
    6)
        echo ""
        flutter doctor -v
        ;;
    q|Q)
        echo "Goodbye!"
        exit 0
        ;;
    *)
        echo "Invalid choice!"
        exit 1
        ;;
esac

