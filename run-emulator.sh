#!/bin/bash

# Set Android SDK path
export ANDROID_HOME=~/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/platform-tools:$ANDROID_HOME/emulator

echo "🍌 Starting Banana Count App..."
echo ""

# Check if emulator is already running
if adb devices | grep -q "emulator"; then
    echo "✓ Emulator is already running"
else
    echo "Starting emulator..."
    # Start emulator in background
    $ANDROID_HOME/emulator/emulator -avd Pixel_5_API_34 -no-snapshot-load &
    
    # Wait for emulator to boot
    echo "Waiting for emulator to boot..."
    adb wait-for-device
    
    # Wait for boot to complete
    while [ "`adb shell getprop sys.boot_completed | tr -d '\r' `" != "1" ]; do
        sleep 1
    done
    echo "✓ Emulator booted successfully"
fi

echo ""
echo "Building and installing app..."
./gradlew installDebug

echo ""
echo "✓ App installed successfully!"
echo ""
echo "Launching Banana Count app..."
adb shell am start -n com.pbrown.bananacount/.MainActivity

echo ""
echo "🍌 Banana Count is now running on the emulator!"
echo ""
echo "To view logs, run: adb logcat | grep BananaCount"

