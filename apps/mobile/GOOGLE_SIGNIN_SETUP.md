# Google Sign-In Setup Guide

## Error Code 10 (DEVELOPER_ERROR)

If you're seeing error code 10, it means the app is not properly configured in Google Cloud Console.

## Setup Steps

### 1. Create a Google Cloud Project

1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Create a new project or select an existing one
3. Enable the **Google Sign-In API** (Identity Platform)

### 2. Configure OAuth Consent Screen

1. Go to **APIs & Services** > **OAuth consent screen**
2. Choose **External** (for testing) or **Internal** (for organization)
3. Fill in the required information:
   - App name: Mob Pizza
   - User support email: your email
   - Developer contact: your email
4. Add scopes: `email`, `profile`
5. Save and continue

### 3. Create OAuth 2.0 Client ID

1. Go to **APIs & Services** > **Credentials**
2. Click **Create Credentials** > **OAuth client ID**
3. Choose **Android** as application type
4. Enter:
   - **Name**: Mob Pizza Android
   - **Package name**: `com.mobpizza.app`
   - **SHA-1 certificate fingerprint**: (see below)

### 4. Get SHA-1 Fingerprint

#### For Debug Build:
```bash
cd android
./gradlew signingReport
```

Look for the SHA-1 fingerprint in the output under `Variant: debug`

Or use:
```bash
keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android
```

#### For Release Build:
```bash
keytool -list -v -keystore android/upload-keystore.jks -alias <your-key-alias>
```

### 5. Add SHA-1 to Firebase (if using Firebase)

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Select your project
3. Go to **Project Settings** > **Your apps**
4. Add Android app with package name: `com.mobpizza.app`
5. Download `google-services.json` and place it in `android/app/`
6. Add SHA-1 fingerprint in Firebase console

### 6. Update Android Configuration

If you downloaded `google-services.json`:
1. Place it in `android/app/google-services.json`
2. Add to `android/build.gradle.kts`:
```kotlin
buildscript {
    dependencies {
        classpath("com.google.gms:google-services:4.4.0")
    }
}
```
3. Add to `android/app/build.gradle.kts`:
```kotlin
plugins {
    // ... existing plugins
    id("com.google.gms.google-services")
}
```

### 7. Optional: Configure Web Client ID

If you want to use server-side authentication, also create a **Web application** OAuth client ID and configure it in the app:

```dart
final _googleSignIn = GoogleSignIn(
  scopes: ['email', 'profile'],
  serverClientId: 'YOUR_WEB_CLIENT_ID.apps.googleusercontent.com',
);
```

## Testing

After configuration:
1. Clean and rebuild the app:
   ```bash
   flutter clean
   flutter pub get
   flutter run
   ```
2. Try Google Sign-In again

## Troubleshooting

- **Error 10**: App not configured in Google Cloud Console
- **Error 12500**: User cancelled sign-in (not an error)
- **Error 7**: Network error
- **Error 8**: Internal error

## Package Name

Current package name: `com.mobpizza.app`

Make sure this matches exactly in:
- Google Cloud Console
- Firebase (if used)
- `android/app/build.gradle.kts` (applicationId)

