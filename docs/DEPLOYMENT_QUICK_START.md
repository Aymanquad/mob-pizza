# MongoDB Migration - Quick Start Guide

## ✅ What's Been Completed

### Backend
- ✅ MongoDB Atlas connection string configured in `env.example`
- ✅ Cart API endpoints created (`/api/v1/cart/:phone`)
- ✅ Order API endpoints created (`/api/v1/orders/:phone`)
- ✅ User model updated with `cart` field
- ✅ All routes wired up in `src/index.js`

### Mobile App
- ✅ Cart service created (`services/cart_service.dart`)
- ✅ Order service created (`services/order_service.dart`)
- ✅ CartProvider updated to use MongoDB API (with offline fallback)
- ✅ OrderProvider updated to use MongoDB API (with offline fallback)
- ✅ Profile sync already working via `user_service.dart`

## 🚀 Deployment Steps

### 1. Backend Setup for Render

1. **Create `.env` file in `apps/backend/`** (copy from `env.example`):
```env
PORT=5000
NODE_ENV=production

# MongoDB Atlas
MONGO_URI=mongodb+srv://Ayman:Ayman2004@cluster0.ax0nlid.mongodb.net/mob-pizza?retryWrites=true&w=majority

# Auth
JWT_SECRET=your-secure-random-string-here
JWT_EXPIRES_IN=7d

# Other services (add as needed)
RESEND_API_KEY=your_resend_api_key
RESEND_FROM_EMAIL=orders@yourdomain.com
```

2. **For Render Deployment:**
   - Go to Render dashboard
   - Create new Web Service
   - Connect your GitHub repo
   - Set build command: `cd apps/backend && npm install`
   - Set start command: `cd apps/backend && npm start`
   - Add environment variables in Render dashboard (especially `MONGO_URI`)

### 2. Mobile App Configuration

Update `apps/mobile/.env` (or use build-time environment variables):
```env
API_BASE_URL=https://your-render-app.onrender.com/api/v1
```

Or for local development:
```env
API_BASE_URL=http://10.0.2.2:5000/api/v1
```

### 3. Test the Integration

1. **Start backend:**
   ```bash
   cd apps/backend
   npm install
   npm run dev
   ```

2. **Test API endpoints:**
   - `GET http://localhost:5000/api/v1/cart/:phone` - Get cart
   - `POST http://localhost:5000/api/v1/cart/:phone` - Add item
   - `GET http://localhost:5000/api/v1/orders/:phone` - Get orders
   - `POST http://localhost:5000/api/v1/orders/:phone` - Create order

3. **Run mobile app:**
   - Ensure backend is running
   - Update API_BASE_URL if needed
   - Test cart operations
   - Test order creation

## 📋 API Endpoints Summary

### Cart Endpoints
- `GET /api/v1/cart/:phone` - Get user's cart
- `POST /api/v1/cart/:phone` - Add item to cart
- `PUT /api/v1/cart/:phone/:itemId` - Update item quantity
- `DELETE /api/v1/cart/:phone/:itemId` - Remove item
- `DELETE /api/v1/cart/:phone` - Clear cart

### Order Endpoints
- `POST /api/v1/orders/:phone` - Create new order
- `GET /api/v1/orders/:phone` - Get user's orders
- `GET /api/v1/orders/:phone/:orderId` - Get single order
- `PUT /api/v1/orders/:phone/:orderId/status` - Update order status

### User Endpoints (existing)
- `GET /api/v1/users/:phone` - Get user profile
- `PUT /api/v1/users/:phone` - Update user profile

## 🔄 How It Works

### Cart Flow
1. User adds item to cart → `CartProvider.addItem()`
2. Provider calls `CartService.addItem()` → API POST request
3. Backend saves to MongoDB in User.cart array
4. Response returns updated cart
5. Provider updates local state
6. SharedPreferences cached as backup

### Order Flow
1. User places order → `OrderProvider.addOrder()`
2. Provider calls `OrderService.createOrder()` → API POST request
3. Backend creates Order document in MongoDB
4. Backend updates User.ordersCount
5. Response returns created order
6. Provider adds to local list
7. SharedPreferences cached as backup

### Offline Support
- If API fails, app falls back to SharedPreferences
- When online, app syncs with MongoDB
- Cart and orders are cached locally for offline viewing

## ⚠️ Important Notes

1. **Database Name:** Connection string includes `/mob-pizza` database name
2. **Phone-based Auth:** Currently using phone number for user identification
3. **Offline First:** App works offline with cached data, syncs when online
4. **Render Deployment:** Make sure to set all environment variables in Render dashboard
5. **CORS:** Backend has CORS enabled, should work with mobile app

## 🐛 Troubleshooting

### Backend won't connect to MongoDB
- Check `MONGO_URI` in `.env` file
- Verify MongoDB Atlas IP whitelist (should allow all IPs for Render)
- Check MongoDB Atlas connection string format

### Mobile app can't reach API
- Verify `API_BASE_URL` in mobile `.env`
- For Android emulator: use `10.0.2.2:5000` instead of `localhost`
- Check backend is running and accessible
- Verify CORS settings in backend

### Cart/Orders not syncing
- Check phone number is saved in SharedPreferences
- Verify API endpoints are working (test with Postman/curl)
- Check network connectivity
- Review debug logs in Flutter console

## ✅ Next Steps (Optional)

1. Add JWT authentication for better security
2. Implement order status webhooks
3. Add admin dashboard for order management
4. Implement web app with same API
5. Add analytics and monitoring

---

**Status:** ✅ Ready for deployment and testing!

