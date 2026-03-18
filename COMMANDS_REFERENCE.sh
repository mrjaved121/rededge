#!/bin/bash
# RED EDGE Flutter App - Command Reference
# Copy and paste these commands to get started

# ==============================================================================
# SETUP & INITIAL RUN
# ==============================================================================

# 1. Navigate to project
cd D:\Desktop\redEdge

# 2. Get all dependencies
flutter pub get

# 3. Generate code (MUST DO FIRST!)
dart run build_runner build --delete-conflicting-outputs

# 4. Check for lint issues
flutter analyze

# 5. Run the app in debug mode
flutter run

# ==============================================================================
# DEVELOPMENT WORKFLOW
# ==============================================================================

# Watch mode - auto-rebuild on code changes
flutter run --debug

# Run on specific device
flutter devices
flutter run -d <device_id>

# Hot reload during development (press 'r' in terminal)
# Hot restart (press 'R' in terminal)

# If code generation broke, clean and rebuild
flutter clean
flutter pub get
dart run build_runner build --delete-conflicting-outputs

# ==============================================================================
# TESTING
# ==============================================================================

# Run all unit tests
flutter test

# Run with coverage report
flutter test --coverage

# Run specific test file
flutter test test/features/auth/domain/usecases/auth_usecase_test.dart

# Integration tests (once created)
flutter drive --target=test_driver/app.dart

# ==============================================================================
# BUILD FOR RELEASE
# ==============================================================================

# Android: Build APK (single file, smaller)
flutter build apk --release

# Android: Build App Bundle (for Play Store, recommended)
flutter build appbundle --release

# Android: Build with split APKs per architecture
flutter build apk --release --split-per-abi

# iOS: Build IPA (for App Store or TestFlight)
flutter build ipa --release

# iOS: Build debug for simulator testing
flutter build ios --debug --no-codesign

# ==============================================================================
# DEBUGGING & TROUBLESHOOTING
# ==============================================================================

# Check Flutter environment
flutter doctor

# Check Flutter version
flutter --version

# See all available devices
flutter devices

# Run with verbose logging
flutter run -v

# Run with profile mode (performance profiling)
flutter run --profile

# Open DevTools for debugging
devtools

# View widget inspector
# Press 'w' in the terminal while app is running

# ==============================================================================
# CODE GENERATION
# ==============================================================================

# Build once
dart run build_runner build --delete-conflicting-outputs

# Continuous build (watches for changes)
dart run build_runner watch --delete-conflicting-outputs

# Clean generated files if stuck
dart run build_runner clean
dart run build_runner build --delete-conflicting-outputs

# ==============================================================================
# DEPENDENCY MANAGEMENT
# ==============================================================================

# Get all dependencies
flutter pub get

# Upgrade all dependencies to latest compatible versions
flutter pub upgrade

# Upgrade all dependencies to latest (breaking changes possible)
flutter pub upgrade --major-versions

# Check for outdated packages
flutter pub outdated

# ==============================================================================
# ANDROID SPECIFIC
# ==============================================================================

# Generate Android signing keystore (FIRST TIME ONLY)
keytool -genkey -v -keystore release.jks -keyalg RSA -keysize 2048 \
  -validity 10000 -alias android_key -keypass android -storepass android

# Build Android app bundle for Play Store
flutter build appbundle --release

# Build debug APK for testing
flutter build apk --debug

# Install APK on connected device
adb install build/app/outputs/flutter-app.apk

# Uninstall app from device
adb uninstall com.rededge.app

# ==============================================================================
# iOS SPECIFIC
# ==============================================================================

# Pod dependencies (do this if iOS build fails)
cd ios
pod install
cd ..

# Build iOS app for device
flutter build ios --release

# Build iOS app for simulator
flutter build ios --simulator

# Open iOS project in Xcode
open ios/Runner.xcworkspace

# ==============================================================================
# GIT WORKFLOW
# ==============================================================================

# Check git status
git status

# Commit changes
git add .
git commit -m "feat: description of changes"

# Create a new branch
git checkout -b feature/feature-name

# Push to remote
git push origin feature/feature-name

# Create pull request
# (Use GitHub/GitLab web interface)

# ==============================================================================
# API & BACKEND INTEGRATION
# ==============================================================================

# Set API URL (when running)
flutter run \
  --dart-define=API_URL=https://api.staging.rededge.io

# Build release with custom API URL
flutter build apk --release \
  --dart-define=API_URL=https://api.production.rededge.io

# ==============================================================================
# PERFORMANCE & PROFILING
# ==============================================================================

# Run app in profile mode (closest to release)
flutter run --profile

# Generate performance trace
flutter run --profile --trace-startup

# Analyze app startup time
flutter analyze

# Check unused code
dart analyze

# ==============================================================================
# DOCUMENTATION & HELP
# ==============================================================================

# View Flutter help
flutter help

# Get help for specific command
flutter help run
flutter help build
flutter help test

# Visit documentation
# https://flutter.dev/docs
# https://riverpod.dev
# https://pub.dev/packages/go_router

# ==============================================================================
# USEFUL ENVIRONMENT VARIABLES
# ==============================================================================

# Set Flutter to use local engine
export FLUTTER_ENGINE=~/flutter/engine

# Skip Gradle daemon for Android builds
export ORG_GRADLE_PROJECT_android_useAndroidX=true

# Increase build timeout
export GRADLE_TIMEOUT=120000

# ==============================================================================
# QUICK REFERENCE
# ==============================================================================

# Most Common Commands:
flutter pub get                    # Get dependencies
dart run build_runner build ...    # Generate code
flutter run                        # Run app
flutter test                       # Run tests
flutter build apk --release        # Build Android release
flutter build ipa --release        # Build iOS release

# Stuck? Try:
flutter clean
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run

# ==============================================================================
# DEVICE EMULATOR COMMANDS
# ==============================================================================

# List running emulators
emulator -list-avds

# Start Android emulator
emulator -avd <emulator_name>

# Start iOS simulator
open -a Simulator

# ==============================================================================
# APP SIGNING & DEPLOYMENT
# ==============================================================================

# For Android - Create signing key (ONE TIME)
keytool -genkey -v -keystore ~/key.jks -keyalg RSA -keysize 2048 -validity 10000

# Sign APK manually (if build system fails)
jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 \
  -keystore ~/key.jks app-release-unsigned.apk alias_name

# For iOS - Configure Xcode signing
# Open ios/Runner.xcworkspace
# Select Runner project
# Go to Signing & Capabilities
# Select team and bundle identifier

# ==============================================================================
# NOTES
# ==============================================================================

# - Always run `dart run build_runner build` after creating new @freezed or @riverpod classes
# - Use `flutter run -v` if you get mysterious errors
# - Check `flutter doctor` if build fails
# - Clean and rebuild if cache is stale: `flutter clean && flutter pub get`
# - For iOS, always use .xcworkspace (not .xcodeproj)
# - Test on actual devices before release, not just emulators

# ==============================================================================
# SUPPORT
# ==============================================================================

# Issues? Check these files:
# - QUICKSTART.md (5-minute setup)
# - README_APP.md (full documentation)
# - IMPLEMENTATION_COMPLETE.md (feature details)
# - FILE_MANIFEST.md (all files created)

# Contact: support@rededge.io

