# Fix MongoDB Phone Index - Instructions

## Problem
The error `E11000 duplicate key error collection: mob-pizza.users index: phone_1 dup key: { phone: null }` occurs because the existing phone index in MongoDB is **not sparse**, even though the code defines it as sparse.

## Root Cause
The index was created before we made it sparse, so the actual database index is still non-sparse and doesn't allow multiple null values.

## Solution

### Option 1: Run the Fix Script (Recommended)
1. Connect to your MongoDB database (via MongoDB Compass, Atlas UI, or mongo shell)
2. Run this script:
   ```bash
   node apps/backend/src/scripts/fix-phone-index.js
   ```

### Option 2: Manual Fix via MongoDB Shell/Compass

1. **Connect to your MongoDB database**

2. **Drop the existing phone index:**
   ```javascript
   db.users.dropIndex("phone_1")
   ```

3. **Create new sparse index:**
   ```javascript
   db.users.createIndex({ phone: 1 }, { sparse: true, unique: true })
   ```

4. **Also fix googleId index:**
   ```javascript
   db.users.dropIndex("googleId_1")
   db.users.createIndex({ googleId: 1 }, { sparse: true, unique: true })
   ```

### Option 3: Via MongoDB Atlas UI

1. Go to your MongoDB Atlas cluster
2. Click "Browse Collections"
3. Select `mob-pizza` database → `users` collection
4. Go to "Indexes" tab
5. Delete the `phone_1` index
6. Click "Create Index"
7. Field: `phone`, Type: `1`, Options: Check "Sparse" and "Unique"
8. Repeat for `googleId_1` index

## Verify Fix

After fixing, verify the indexes are sparse:
```javascript
db.users.getIndexes()
```

You should see:
```javascript
{
  "v": 2,
  "key": { "phone": 1 },
  "unique": true,
  "sparse": true,
  "name": "phone_1"
}
```

## Code Changes

The code has been updated to:
- ✅ Not set phone field if not provided (avoids null values)
- ✅ Index definition is sparse in the model
- ✅ Only set phone when a valid value is provided

After fixing the database index, the duplicate key error should be resolved.

