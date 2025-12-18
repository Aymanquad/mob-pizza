# Release Signing Setup for Play Store

## Quick Setup (One-Time)

### Step 1: Create Keystore

Run this command in `apps/mobile/android` directory:

**Windows (PowerShell):**
```powershell
cd apps/mobile/android
keytool -genkey -v -keystore upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```

**Mac/Linux:**
```bash
cd apps/mobile/android
keytool -genkey -v -keystore upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```

**Important:** 
- You'll be asked for a password - **SAVE IT!** You'll need it forever
- Fill in the information (name, organization, etc.)
- The keystore file will be created in `apps/mobile/android/upload-keystore.jks`

### Step 2: Create key.properties

Create file: `apps/mobile/android/key.properties`

```properties
storePassword=YOUR_STORE_PASSWORD_HERE
keyPassword=YOUR_KEY_PASSWORD_HERE
keyAlias=upload
storeFile=upload-keystore.jks
```

**Replace:**
- `YOUR_STORE_PASSWORD_HERE` with the password you entered when creating keystore
- `YOUR_KEY_PASSWORD_HERE` with the same password (or key password if different)

### Step 3: Add to .gitignore

Make sure `apps/mobile/android/key.properties` and `apps/mobile/android/upload-keystore.jks` are in `.gitignore`:

```
apps/mobile/android/key.properties
apps/mobile/android/upload-keystore.jks
```

### Step 4: Build Again

```bash
cd apps/mobile
flutter clean
flutter build appbundle --release
```

## What Changed

✅ `build.gradle.kts` now loads keystore from `key.properties`
✅ Release builds will use your keystore for signing
✅ Debug builds still work normally

## Security Notes

⚠️ **NEVER commit these files to git:**
- `key.properties`
- `upload-keystore.jks`

⚠️ **BACKUP your keystore!** If you lose it, you can't update your app on Play Store.

## Troubleshooting

### "key.properties not found"
- Make sure file exists at `apps/mobile/android/key.properties`
- Check file path in `key.properties` matches your keystore location

### "Wrong password"
- Double-check passwords in `key.properties`
- Make sure no extra spaces or quotes

### "Keystore file not found"
- Verify `storeFile` path in `key.properties` is correct
- Path should be relative to `android/` directory

---

**After setup, your .aab will be properly signed for Play Store!** ✅

