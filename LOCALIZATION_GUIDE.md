# 🌐 Localization Guide - English ↔ Spanish Translation

## ✅ Current Status

**Good news!** The localization infrastructure is **already set up** in your Flutter app:

- ✅ `flutter_localizations` package installed
- ✅ Translation files exist: `app_en.arb` and `app_es.arb`
- ✅ `AppLocalizations` class auto-generated
- ✅ `MaterialApp` wired to use `LocaleProvider`
- ✅ Language toggle works in onboarding and profile

**What's missing:** Most screens use hardcoded strings instead of translations.

---

## 🎯 How It Works

### Architecture

```
User changes language → LocaleProvider updates → MaterialApp rebuilds → Screens use AppLocalizations
```

### Files Structure

```
apps/mobile/
├── l10n.yaml                           # L10n config
├── lib/
│   ├── l10n/
│   │   ├── app_en.arb                 # English translations
│   │   ├── app_es.arb                 # Spanish translations
│   │   ├── app_localizations.dart     # Generated (DO NOT EDIT)
│   │   ├── app_localizations_en.dart  # Generated
│   │   └── app_localizations_es.dart  # Generated
│   ├── providers/
│   │   └── locale_provider.dart       # Manages current locale
│   └── main.dart                       # Wires everything up
```

---

## 📝 How to Use Translations

### Step 1: Add Translation Keys

**File:** `apps/mobile/lib/l10n/app_en.arb`

```json
{
  "@@locale": "en",
  "profile": "Profile",
  "editProfile": "Edit Profile",
  "firstName": "First Name",
  "lastName": "Last Name",
  "saveChanges": "Save Changes",
  "logout": "Log out"
}
```

**File:** `apps/mobile/lib/l10n/app_es.arb`

```json
{
  "@@locale": "es",
  "profile": "Perfil",
  "editProfile": "Editar perfil",
  "firstName": "Nombre",
  "lastName": "Apellido",
  "saveChanges": "Guardar cambios",
  "logout": "Cerrar sesión"
}
```

### Step 2: Regenerate Translations

After editing `.arb` files, run:

```bash
cd apps/mobile
flutter gen-l10n
```

Or simply:

```bash
flutter run
```

(Flutter auto-generates on run)

### Step 3: Use in Screens

**Before (Hardcoded):**

```dart
Text('Profile')
```

**After (Localized):**

```dart
import 'package:mob_pizza_mobile/l10n/app_localizations.dart';

// In build method:
Text(AppLocalizations.of(context)!.profile)
```

**Shorthand:**

```dart
final l10n = AppLocalizations.of(context)!;

// Now use:
Text(l10n.profile)
Text(l10n.editProfile)
Text(l10n.firstName)
```

---

## 🔧 Implementation Checklist

### ✅ Already Done

- [x] Install `flutter_localizations`
- [x] Create `l10n.yaml` config
- [x] Create translation files (`.arb`)
- [x] Wire `MaterialApp` with localization delegates
- [x] Create `LocaleProvider` for state management
- [x] Add language toggle in onboarding
- [x] Add language toggle in profile

### 🚧 TODO: Update Screens to Use Translations

#### 1. **Onboarding Screen** (`lib/screens/onboarding/onboarding_screen.dart`)

**Add to `.arb` files:**

```json
// app_en.arb
{
  "joinTheFamily": "Join the Family",
  "phoneNumber": "Phone Number",
  "language": "Language",
  "english": "English",
  "spanish": "Spanish",
  "allowLocation": "Allow Location",
  "allowNotifications": "Allow Notifications",
  "locationHelps": "Helps confirm delivery area",
  "notificationsHelps": "Order updates & offers",
  "requestPermissions": "Request Permissions",
  "continue": "Continue",
  "phoneRequired": "Phone is required",
  "enterValidPhone": "Enter valid phone",
  "onboardingSuccess": "Onboarding successful! Taking you to the main page...",
  "onboardingFailed": "Failed to complete onboarding"
}

// app_es.arb
{
  "joinTheFamily": "Únete a la Familia",
  "phoneNumber": "Número de teléfono",
  "language": "Idioma",
  "english": "Inglés",
  "spanish": "Español",
  "allowLocation": "Permitir ubicación",
  "allowNotifications": "Permitir notificaciones",
  "locationHelps": "Ayuda a confirmar el área de entrega",
  "notificationsHelps": "Actualizaciones de pedidos y ofertas",
  "requestPermissions": "Solicitar permisos",
  "continue": "Continuar",
  "phoneRequired": "El teléfono es obligatorio",
  "enterValidPhone": "Ingresa un teléfono válido",
  "onboardingSuccess": "¡Registro exitoso! Llevándote a la página principal...",
  "onboardingFailed": "Error al completar el registro"
}
```

**Update code:**

```dart
final l10n = AppLocalizations.of(context)!;

// Replace:
Text('Join the Family') → Text(l10n.joinTheFamily)
Text('Phone Number') → Text(l10n.phoneNumber)
Text('Continue') → Text(l10n.continue)
// etc.
```

#### 2. **Profile Screen** (`lib/screens/profile/profile_screen.dart`)

**Add to `.arb` files:**

```json
// app_en.arb
{
  "name": "Name",
  "firstName": "First Name",
  "lastName": "Last Name",
  "address": "Address",
  "streetAddress": "Street Address",
  "contact": "Contact",
  "phone": "Phone",
  "required": "Required",
  "profileUpdated": "Profile updated successfully",
  "profileUpdateFailed": "Failed to update profile",
  "loggedOut": "Logged out"
}

// app_es.arb
{
  "name": "Nombre",
  "firstName": "Nombre",
  "lastName": "Apellido",
  "address": "Dirección",
  "streetAddress": "Dirección de la calle",
  "contact": "Contacto",
  "phone": "Teléfono",
  "required": "Obligatorio",
  "profileUpdated": "Perfil actualizado con éxito",
  "profileUpdateFailed": "Error al actualizar el perfil",
  "loggedOut": "Sesión cerrada"
}
```

#### 3. **Home Screen** (`lib/screens/home/home_screen.dart`)

Already has keys in `.arb` files:
- `homeScreenTitle`
- `homeScreenSubtitle`
- `homeScreenDescription`
- `orderNow`
- `trackJobs`

**Just need to use them:**

```dart
final l10n = AppLocalizations.of(context)!;

Text(l10n.homeScreenTitle)
Text(l10n.orderNow)
// etc.
```

#### 4. **Bottom Navigation Bar**

Use existing keys:
- `navHome` / `navMenu` / `navCart` / `navOrders` / `navProfile`

---

## 🔄 Testing Language Switch

### Test Flow

1. **Launch app** → Onboarding screen (English by default)
2. **Select Spanish** from dropdown → UI should show "Español"
3. **Complete onboarding** → Navigate to home
4. **Go to Profile** → Tap language switch → Toggle to English
5. **Tap Save** → UI should update immediately
6. **Navigate between tabs** → All text should be in selected language
7. **Logout & re-login** → Language preference should persist

### How to Verify

- Home screen title changes: "The Don's Briefing" ↔ "El Informe del Don"
- Button text changes: "Continue" ↔ "Continuar"
- Navigation labels change: "Profile" ↔ "Perfil"

---

## 📋 Quick Reference: Common Translation Patterns

### Simple Text

```dart
Text(AppLocalizations.of(context)!.profile)
```

### Button Labels

```dart
ElevatedButton(
  onPressed: _save,
  child: Text(AppLocalizations.of(context)!.saveChanges),
)
```

### Form Labels

```dart
TextFormField(
  decoration: InputDecoration(
    labelText: AppLocalizations.of(context)!.firstName,
  ),
)
```

### Validation Messages

```dart
validator: (value) {
  final l10n = AppLocalizations.of(context)!;
  if (value?.isEmpty ?? true) {
    return l10n.required;
  }
  return null;
}
```

### Snackbar Messages

```dart
ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: Text(AppLocalizations.of(context)!.profileUpdated),
  ),
)
```

### ListTile with Translations

```dart
ListTile(
  title: Text(AppLocalizations.of(context)!.address),
  subtitle: Text(_address),
)
```

---

## 🐛 Troubleshooting

### Issue: "AppLocalizations is not defined"

**Solution:** Import the localization file:

```dart
import 'package:mob_pizza_mobile/l10n/app_localizations.dart';
```

### Issue: "Key not found in translations"

**Solution:**
1. Add the key to both `app_en.arb` AND `app_es.arb`
2. Run `flutter gen-l10n` or restart `flutter run`

### Issue: "Language doesn't change when I toggle"

**Solution:** Make sure:
1. `LocaleProvider.setLocale()` is being called
2. The Provider is wrapped around `MaterialApp`
3. `locale: localeProvider.locale` is set in `MaterialApp`
4. You're using `AppLocalizations.of(context)!.key` (not hardcoded strings)

### Issue: "Translations not updating"

**Solution:**
1. Hot restart (not hot reload) → `R` in terminal
2. Re-run `flutter gen-l10n`
3. Check that both `.arb` files have the same keys

---

## 🚀 Implementation Priority

### Phase 1: Critical Screens (Do First)
1. ✅ Onboarding Screen
2. ✅ Profile Screen
3. Home Screen
4. Bottom Navigation Bar

### Phase 2: Secondary Screens
5. Menu Screen
6. Cart Screen
7. Orders Screen

### Phase 3: Detail Screens
8. Item Detail Screen
9. Checkout Screen
10. Order Detail Screen

---

## 📦 Summary

| Feature | Status | Location |
|---------|--------|----------|
| Translation files | ✅ Set up | `lib/l10n/*.arb` |
| Auto-generation | ✅ Working | `flutter gen-l10n` |
| Locale provider | ✅ Working | `lib/providers/locale_provider.dart` |
| MaterialApp wiring | ✅ Done | `lib/main.dart` |
| Onboarding toggle | ✅ Working | Language selector exists |
| Profile toggle | ✅ Working | Switch button exists |
| Screens using translations | ⚠️ Partial | Most still hardcoded |

**Action Required:** Replace hardcoded strings with `AppLocalizations.of(context)!.key` in all screens.

---

## 💡 Pro Tips

1. **Always add to BOTH .arb files** - Keep keys in sync
2. **Use descriptive keys** - `firstName` better than `field1`
3. **Test both languages** - Switch back and forth frequently
4. **Use l10n shorthand** - `final l10n = AppLocalizations.of(context)!;`
5. **Hot restart for .arb changes** - Hot reload won't pick up new translations
6. **Check generated files** - If confused, look at `app_localizations.dart`

---

## 🎬 Next Steps

1. **Add onboarding translation keys** to both `.arb` files
2. **Update onboarding_screen.dart** to use `AppLocalizations`
3. **Add profile translation keys** to both `.arb` files
4. **Update profile_screen.dart** to use `AppLocalizations`
5. **Test language switching** end-to-end
6. **Repeat for remaining screens** (Home, Menu, Cart, Orders)

---

**Questions?** The system is already wired - you just need to use it! 🎯

