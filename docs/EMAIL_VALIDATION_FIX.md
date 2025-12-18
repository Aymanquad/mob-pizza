# Email Validation Fix

## Issue
Cart items were failing to save because of email validation error:
```
User validation failed: email: Please enter a valid email
Value: '8106020042@placeholder.local'
```

## Root Cause
The email validation regex was too strict:
- Old regex: `/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/`
- This only allowed TLDs with 2-3 characters (like `.com`, `.org`)
- Placeholder emails use `.local` (5 characters), which failed validation

## Fix Applied
Updated email validation regex in `apps/backend/src/models/User.js`:
```javascript
match: [/^[^\s@]+@[^\s@]+\.[^\s@]+$/, 'Please enter a valid email']
```

This new regex:
- Allows any TLD length (`.local`, `.online`, `.museum`, etc.)
- Still validates basic email format (has @ and .)
- More permissive for placeholder emails

## Action Required
**Restart the backend server** for changes to take effect:
```bash
# Stop current server (Ctrl+C)
# Then restart:
cd apps/backend
npm run dev
```

## Testing
After restart:
1. Add item to cart in mobile app
2. Check backend logs - should see success
3. Check MongoDB - cart array should have items

