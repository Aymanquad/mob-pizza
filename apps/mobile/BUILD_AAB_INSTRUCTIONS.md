# Build .AAB File for Google Play Store - Closed Testing

## ✅ Version Code Updated
- **Previous:** `0.1.0+3`
- **Current:** `0.1.0+4` (updated in `pubspec.yaml`)

The version code has been incremented to **4** for this Play Store upload.

---

## Method 1: Using Android Studio (Recommended)

### Step 1: Open Project in Android Studio
1. Open **Android Studio**
2. Click **File** → **Open**
3. Navigate to: `apps/mobile/android`
4. Click **OK**

### Step 2: Build the AAB
1. In Android Studio, go to **Build** → **Flutter** → **Build App Bundle**
   - OR use the terminal in Android Studio (bottom panel)
2. Wait for the build to complete (5-10 minutes)

### Step 3: Locate the AAB File
The file will be at:
```
apps/mobile/build/app/outputs/bundle/release/app-release.aab
```

---

## Method 2: Using Terminal/Command Line

### Step 1: Navigate to Mobile Directory
```bash
cd apps/mobile
```

### Step 2: Clean Previous Builds (Optional but Recommended)
```bash
flutter clean
```

### Step 3: Get Dependencies
```bash
flutter pub get
```

### Step 4: Build the AAB File
```bash
flutter build appbundle --release
```

### Step 5: Locate the AAB File
The file will be at:
```
apps/mobile/build/app/outputs/bundle/release/app-release.aab
```

---

## Method 3: Using Android Studio Gradle Panel

1. Open Android Studio
2. Open the project at `apps/mobile/android`
3. On the right side, open the **Gradle** panel
4. Navigate to: **mob_pizza_mobile** → **Tasks** → **build**
5. Double-click **bundleRelease**
6. Wait for build to complete
7. Find the AAB at: `apps/mobile/build/app/outputs/bundle/release/app-release.aab`

---

## Upload to Google Play Console

1. Go to [Google Play Console](https://play.google.com/console)
2. Select your app (or create a new one)
3. Navigate to **Testing** → **Closed testing**
4. Click **Create new release** (or edit existing)
5. Click **Upload** and select `app-release.aab`
6. Fill in **Release notes** (e.g., "Initial closed testing release")
7. Click **Save**
8. Click **Review release**
9. Review and click **Start rollout to Closed testing**

---

## Important Notes

### ✅ For Closed Testing:
- **Signing:** Google Play can sign your app automatically (App Signing by Google Play)
- **Debug signing works fine** for closed testing
- No need for manual keystore setup at this stage

### ⚠️ For Production:
- You'll need proper app signing
- Google Play will handle signing if you enable "App Signing by Google Play"

### Version Code Rules:
- Each upload to Play Store **must** have a higher version code
- Current version code: **4**
- Next upload should be: **5** (increment in `pubspec.yaml`)

---

## Troubleshooting

### Build Fails with "Signing Error"
- For closed testing, this shouldn't happen
- If it does, check `android/key.properties` exists
- The build will use debug signing if release signing isn't configured

### Build Fails with "Version Code Error"
- Make sure version code in `pubspec.yaml` is higher than previous uploads
- Current: `0.1.0+4`

### Build is Slow
- This is normal! Release builds take 5-10 minutes
- First build may take longer

### Can't Find the AAB File
- Check: `apps/mobile/build/app/outputs/bundle/release/`
- Make sure build completed successfully (check for errors)

---

## Quick Reference Commands

```bash
# Navigate to mobile app
cd apps/mobile

# Clean and rebuild
flutter clean
flutter pub get
flutter build appbundle --release

# The AAB file location
# apps/mobile/build/app/outputs/bundle/release/app-release.aab
```

---

**Your .aab file is ready for Play Store closed testing!** 🚀

