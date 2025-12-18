# Simple Commands to Build .AAB File

## Quick Build (5 Steps)

```bash
# 1. Go to mobile app folder
cd apps/mobile

# 2. Clean old builds
flutter clean

# 3. Get dependencies
flutter pub get

# 4. Build .aab file
flutter build appbundle --release

# 5. Your file is here:
# build/app/outputs/bundle/release/app-release.aab
```

## That's It! 🎉

Your `.aab` file is ready at:
```
apps/mobile/build/app/outputs/bundle/release/app-release.aab
```

## For Play Store Upload

**Good News:** For closed testing, you don't need to set up signing! ✅
- Google Play will sign your app automatically
- Just build and upload the .aab file

**For Production:** You'll need proper signing later, but not now.

## Upload to Play Store

1. Go to [Google Play Console](https://play.google.com/console)
2. Create app → Testing → Closed testing
3. Upload `app-release.aab`
4. Done!

