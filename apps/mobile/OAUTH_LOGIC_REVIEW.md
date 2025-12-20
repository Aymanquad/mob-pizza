# OAuth/Google Sign-In Logic Review & Fixes

## Issues Found & Fixed

### 1. ✅ **Empty lastName Handling**
**Problem**: Single-word Google names (e.g., "Ayman") caused empty lastName strings, leading to validation errors.

**Fix**:
- Mobile: Sends `null` instead of empty string for lastName
- Backend: Handles empty strings with `.trim()` and defaults to 'User'
- Service: Only includes lastName in payload if not null/empty

### 2. ✅ **Email/GoogleId Validation**
**Problem**: No validation that email and googleId are non-empty strings.

**Fix**:
- Mobile: Validates email and googleId are not empty before submission
- Backend: Validates email and googleId are non-empty strings with proper type checking
- Backend: Trims values before saving to database

### 3. ✅ **Profile Loading for OAuth Users**
**Problem**: Profile screen only loaded if phone exists, but OAuth users might not have phone.

**Fix**:
- Profile screen now loads using phone OR email as identifier
- Backend getProfile supports phone, email, or googleId lookup
- Profile screen updates both phone and email from backend if available

### 4. ✅ **Profile Update for OAuth Users**
**Problem**: Profile update only worked with phone, not email/googleId.

**Fix**:
- Backend updateProfile now supports phone, email, or googleId
- Mobile profile screen uses phone or email as identifier for updates

### 5. ✅ **Better Error Handling**
**Problem**: Generic 500 errors didn't show validation issues.

**Fix**:
- Backend returns detailed validation errors
- Mobile shows better error messages

## Current Flow

### Google Sign-In Flow:
1. ✅ Signs out first to force account selection
2. ✅ Clears old phone number
3. ✅ Validates email and googleId are not empty
4. ✅ Handles single-word names (lastName defaults to 'User')
5. ✅ Sends null for empty lastName (not empty string)
6. ✅ Phone is optional for OAuth users

### Backend Validation:
1. ✅ Validates either phone OR (email + googleId)
2. ✅ Validates email and googleId are non-empty strings
3. ✅ Trims all string values before saving
4. ✅ Provides defaults: firstName='Guest', lastName='User'
5. ✅ Handles empty strings properly

### Profile Management:
1. ✅ Loads profile by phone OR email
2. ✅ Updates profile by phone OR email
3. ✅ Shows email in profile screen
4. ✅ Handles OAuth users without phone

### Checkout:
1. ✅ Phone is required at checkout (already implemented)
2. ✅ OAuth users must provide phone when placing order

## Edge Cases Handled

- ✅ Single-word Google names → lastName defaults to 'User'
- ✅ Empty email/googleId → Validation error
- ✅ OAuth user without phone → Profile loads by email
- ✅ Phone-based user → Works as before
- ✅ User switches from phone to OAuth → Old phone cleared
- ✅ User switches Google accounts → Account picker shown
- ✅ Empty strings → Converted to null or defaults
- ✅ Invalid email format → MongoDB validation catches it

## Testing Checklist

- [ ] Google Sign-In with full name (first + last)
- [ ] Google Sign-In with single name
- [ ] Google Sign-In with phone number
- [ ] Google Sign-In without phone number
- [ ] Profile loads for OAuth user (no phone)
- [ ] Profile loads for phone-based user
- [ ] Profile update works for OAuth user
- [ ] Profile update works for phone-based user
- [ ] Checkout requires phone (even for OAuth users)
- [ ] Switching Google accounts works
- [ ] Email displays in profile screen

