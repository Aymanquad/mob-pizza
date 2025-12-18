# Mobile App Configuration

## API Base URL

The mobile app is now configured to use the deployed backend on Render.

### Production (Default)
- **Backend URL:** `https://mob-pizza.onrender.com/api/v1`
- **Status:** ✅ Active

### Local Development

If you need to test with a local backend, you can override the API URL:

#### Option 1: Environment Variable (Recommended)
Set the `API_BASE_URL` environment variable when running:

**For Android Emulator:**
```bash
flutter run --dart-define=API_BASE_URL=http://10.0.2.2:5000/api/v1
```

**For iOS Simulator:**
```bash
flutter run --dart-define=API_BASE_URL=http://localhost:5000/api/v1
```

**For Physical Device (same network):**
```bash
flutter run --dart-define=API_BASE_URL=http://YOUR_LOCAL_IP:5000/api/v1
```
(Replace `YOUR_LOCAL_IP` with your computer's local IP address, e.g., `192.168.1.100`)

#### Option 2: Update constants.dart
Temporarily change the default in `apps/mobile/lib/config/constants.dart`:
```dart
const String apiBaseUrl =
    String.fromEnvironment('API_BASE_URL', defaultValue: 'http://10.0.2.2:5000/api/v1');
```

## Configuration Files

- **Main Config:** `apps/mobile/lib/config/constants.dart`
- **Example Env:** `apps/mobile/env.example`

## Services Using API

All services automatically use the configured `apiBaseUrl`:

- ✅ `CartService` - Cart operations
- ✅ `OrderService` - Order management
- ✅ `UserService` - User profile
- ✅ `OnboardingService` - User onboarding

## Testing

To verify the connection:
1. Run the mobile app
2. Check debug logs for API calls
3. Look for: `[service_name] GET/POST https://mob-pizza.onrender.com/api/v1/...`

## Troubleshooting

### Can't connect to backend
- Verify backend is running: `https://mob-pizza.onrender.com`
- Check CORS settings on backend
- Verify network connectivity

### Want to use local backend
- Use environment variable override (see above)
- Or temporarily change default in `constants.dart`

---

**Current Status:** ✅ Connected to production backend on Render

