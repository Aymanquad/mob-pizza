# Data Storage Explanation - Mob Pizza MongoDB

## 📍 Where Data is Stored

### 1. **User Document** (`users` collection)
The user document contains:
- ✅ **Profile Info**: firstName, lastName, email, phone, role
- ✅ **Cart Items**: `cart` array (embedded in user document)
- ✅ **Addresses**: `addresses` array (embedded in user document)
- ✅ **Order Count**: `ordersCount`, `lastOrderAt` (summary only)
- ❌ **Orders**: NOT stored here (see below)

**Example User Document:**
```json
{
  "_id": ObjectId("..."),
  "phone": "8106020042",
  "firstName": "Ayman",
  "lastName": "Quadri",
  "cart": [
    {
      "id": "item123",
      "name": "Margherita Pizza",
      "basePrice": 299,
      "selectedSize": "Crew",
      "quantity": 2
    }
  ],
  "addresses": [
    {
      "label": "home",
      "street": "123 Main St",
      "city": "Mumbai",
      "state": "Maharashtra",
      "zipCode": "400001",
      "isDefault": true
    }
  ],
  "ordersCount": 5,
  "lastOrderAt": "2024-12-18T10:30:00Z"
}
```

### 2. **Orders Collection** (`orders` collection)
Orders are stored in a **separate collection**, NOT embedded in the user document.

**Why?**
- Orders can be large documents
- Better for querying and indexing
- Allows efficient admin queries across all orders
- Better performance

**Order Document:**
```json
{
  "_id": ObjectId("..."),
  "orderId": "ORD-20241218-001",
  "customer": ObjectId("..."),  // Reference to User._id
  "items": [...],
  "totalAmount": 599,
  "orderStatus": "pending",
  "createdAt": "2024-12-18T10:30:00Z"
}
```

**How to find user's orders:**
```javascript
// In MongoDB Compass or query
db.orders.find({ customer: ObjectId("user_id_here") })
```

### 3. **Menu Items Collection** (`menuitems` collection)
Menu items are stored separately and referenced in orders.

---

## 🔄 Data Flow

### **Cart Items**
1. User adds item → `CartProvider.addItem()`
2. Calls `CartService.addItem(phone, item)` → API: `POST /api/v1/cart/:phone`
3. Backend saves to `User.cart` array in MongoDB
4. Response returns updated cart
5. Cart is cached in SharedPreferences as backup

**Storage Location:** `users` collection → `cart` array

### **Addresses**
1. User updates profile → `ProfileScreen._saveProfile()`
2. Calls `UserService.updateProfile(phone, { addresses: [...] })` → API: `PUT /api/v1/users/:phone`
3. Backend saves to `User.addresses` array in MongoDB
4. Address is also cached in SharedPreferences

**Storage Location:** `users` collection → `addresses` array

### **Orders**
1. User places order → `OrderProvider.addOrder()`
2. Calls `OrderService.createOrder(phone, orderData)` → API: `POST /api/v1/orders/:phone`
3. Backend creates document in `orders` collection with `customer: user._id`
4. Backend updates `User.ordersCount` and `User.lastOrderAt`
5. Order is cached in SharedPreferences as backup

**Storage Location:** `orders` collection (separate from users)

---

## 🔍 How to View Data in MongoDB Compass

### View User's Cart:
1. Open `users` collection
2. Find user by phone: `{ phone: "8106020042" }`
3. Expand `cart` array to see items

### View User's Addresses:
1. Open `users` collection
2. Find user by phone: `{ phone: "8106020042" }`
3. Expand `addresses` array to see addresses

### View User's Orders:
1. Open `orders` collection
2. Find orders by customer ID:
   ```javascript
   // First, get user's _id from users collection
   // Then query:
   { customer: ObjectId("user_id_here") }
   ```
3. Or use aggregation to join:
   ```javascript
   db.orders.aggregate([
     { $match: { customer: ObjectId("user_id") } },
     { $lookup: {
         from: "users",
         localField: "customer",
         foreignField: "_id",
         as: "customerInfo"
       }
     }
   ])
   ```

---

## ⚠️ Common Issues

### Cart is Empty in MongoDB
**Possible causes:**
- Cart items not being added via API (check network logs)
- Cart being cleared after order
- API endpoint not working (check backend logs)
- Phone number mismatch

**Fix:** Add item to cart in app, check backend logs for API call

### Addresses Not Saving
**Possible causes:**
- Address field not being sent in update request
- Validation failing (city, state, zipCode required)
- Backend not processing addresses array

**Fix:** Check profile update API call includes addresses array

### Can't Find Orders in User Document
**This is normal!** Orders are in a separate `orders` collection.
- User document only has `ordersCount` (number) and `lastOrderAt` (date)
- Full order details are in `orders` collection
- Query orders by `customer` field

---

## ✅ Verification Checklist

- [ ] Cart items appear in `users.cart` array after adding items
- [ ] Addresses appear in `users.addresses` array after profile update
- [ ] Orders appear in `orders` collection after placing order
- [ ] `users.ordersCount` increases after placing order
- [ ] `users.lastOrderAt` updates after placing order

---

**Last Updated:** 2024-12-18

