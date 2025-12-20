# Backend Deployment Fix

## Issue
The backend on Render is returning error: `"Valid phone is required"` even though the code has been updated to support OAuth without phone.

## Root Cause
The backend code on Render is running an **old version** that still requires phone numbers. The local code has been updated correctly.

## Solution: Deploy Updated Backend

You need to deploy the updated backend code to Render. The updated code:
- ✅ Supports OAuth flow (email + googleId) without phone
- ✅ Makes phone optional for OAuth users
- ✅ Has proper validation logic

## Steps to Deploy

### Option 1: If Render is connected to Git (Auto-deploy)
1. Commit the backend changes:
   ```bash
   git add apps/backend/src/controllers/onboarding.controller.js
   git add apps/backend/src/models/User.js
   git commit -m "Add OAuth support with optional phone number"
   git push
   ```
2. Render should automatically deploy the new code
3. Wait for deployment to complete (check Render dashboard)

### Option 2: Manual Deploy
1. Go to your Render dashboard
2. Find your backend service
3. Click "Manual Deploy" or trigger a new deployment
4. Wait for deployment to complete

## Verify Deployment

After deployment, check the backend logs on Render. You should see:
- `[onboarding] payload` logs showing email, googleId, etc.
- `[onboarding] validation check` logs showing `isOAuthFlow: true`

## Current Code Status

✅ **Local code is correct:**
- `apps/backend/src/controllers/onboarding.controller.js` - Updated
- `apps/backend/src/models/User.js` - Phone is optional

❌ **Render backend is outdated** - Needs deployment

## Test After Deployment

Once deployed, try Google Sign-In again. It should work without requiring a phone number.

