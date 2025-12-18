# Build .AAB File for Google Play Store

## Quick Commands

### 1. Navigate to mobile app directory
```bash
cd apps/mobile
```

### 2. Clean previous builds
```bash
flutter clean
```

### 3. Get dependencies
```bash
flutter pub get
```

### 4. Build the .aab file
```bash
flutter build appbundle --release
```

### 5. Find your .aab file
The file will be located at:
```
apps/mobile/build/app/outputs/bundle/release/app-release.aab
```

## Before Building - Important Checks

### 1. Update App Name (if needed)
Edit `android/app/src/main/AndroidManifest.xml`:
```xml
android:label="Mob Pizza"
```

### 2. Update Version Number
Edit `pubspec.yaml`:
```yaml
version: 1.0.0+1
```
- First number (1.0.0) = version name (shown to users)
- Second number (+1) = version code (must increase for each upload)

### 3. App Signing

**For Closed Testing: NOT NECESSARY** ✅
- Google Play can sign your app automatically
- Debug signing works fine for closed testing
- You can skip this step!

**For Production Release: YES, REQUIRED** ⚠️
- You need proper signing for production
- Create keystore (one-time setup):
```bash
keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```
- Then create `android/key.properties` with your keystore details
- Configure signing in `build.gradle.kts`

**For now (closed testing):** Just build and upload! 🚀

## Complete Step-by-Step

1. **Open terminal in project root**
2. **Navigate:** `cd apps/mobile`
3. **Clean:** `flutter clean`
4. **Get deps:** `flutter pub get`
5. **Build:** `flutter build appbundle --release`
6. **Find file:** `build/app/outputs/bundle/release/app-release.aab`

## Upload to Play Store

1. Go to [Google Play Console](https://play.google.com/console)
2. Create new app or select existing
3. Go to "Testing" → "Closed testing"
4. Create new release
5. Upload `app-release.aab`
6. Fill in release notes
7. Review and publish

## Troubleshooting

### Build fails with signing error
- Make sure `key.properties` exists and is correct
- Verify keystore file path is correct

### Build fails with version error
- Increase version code in `pubspec.yaml` (+1)

### Build is too slow
- This is normal for release builds
- Can take 5-10 minutes

---

**Your .aab file is ready for Play Store!** 🚀

