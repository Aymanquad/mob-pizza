# MOB PIZZA - API SPECIFICATION & Integration Guide (Updated with Flutter)

## 📡 API Overview

**Base URL:** `https://api.mobpizza.com/api/v1` (Production)
**Development URL:** `http://localhost:5000/api/v1`
**API Type:** RESTful JSON API
**Authentication:** JWT Bearer Token
**Rate Limiting:** 100 requests/minute per IP

---

## 🔐 Authentication & Headers

### Header Requirements
```
Authorization: Bearer <JWT_TOKEN>
Content-Type: application/json
Accept: application/json
```

### JWT Token Structure
```
Header: { "alg": "HS256", "typ": "JWT" }
Payload: {
  "userId": "user_id",
  "email": "user@example.com",
  "role": "customer|admin|delivery",
  "iat": 1234567890,
  "exp": 1234671490
}
Signature: HMACSHA256(header.payload, secret_key)
```

---

## 📋 COMPLETE API ENDPOINTS (40+)

### 1️⃣ AUTHENTICATION ENDPOINTS (6)

```
POST   /auth/register            # User registration
POST   /auth/login               # User login
POST   /auth/logout              # User logout
POST   /auth/refresh-token       # Refresh JWT
POST   /auth/forgot-password     # Request password reset
POST   /auth/reset-password      # Reset password
```

**Example Register Request:**
```json
POST /auth/register
{
  "firstName": "John",
  "lastName": "Doe",
  "email": "john@example.com",
  "phone": "+919876543210",
  "password": "SecurePassword123",
  "confirmPassword": "SecurePassword123"
}

Response (201):
{
  "success": true,
  "message": "User registered successfully",
  "data": {
    "userId": "507f1f77bcf86cd799439011",
    "email": "john@example.com"
  },
  "token": {
    "accessToken": "eyJhbGc...",
    "refreshToken": "eyJhbGc...",
    "expiresIn": 86400
  }
}
```

---

### 2️⃣ MENU ENDPOINTS (6)

```
GET    /menu/items              # Get all menu items
GET    /menu/items/:id          # Get single item details
GET    /menu/categories         # Get all categories
GET    /menu/search             # Search items
GET    /menu/featured           # Get featured items
GET    /menu/deals              # Get current deals
```

**Example Get Menu:**
```json
GET /menu/items?category=pizzas&skip=0&limit=20

Response (200):
{
  "success": true,
  "data": {
    "total": 45,
    "items": [
      {
        "id": "507f1f77bcf86cd799439011",
        "name": "Margherita Pizza",
        "category": "pizzas",
        "image": "https://cdn.example.com/pizza1.jpg",
        "basePrice": 299,
        "sizes": [
          { "name": "Small", "price": 299 },
          { "name": "Medium", "price": 399 },
          { "name": "Large", "price": 499 }
        ],
        "isVegetarian": true,
        "rating": 4.5,
        "reviewCount": 234
      }
    ]
  }
}
```

---

### 3️⃣ ORDER ENDPOINTS (6)

```
POST   /orders                  # Create order
GET    /orders                  # Get user's orders
GET    /orders/:id              # Get order details
PUT    /orders/:id              # Update order
DELETE /orders/:id              # Cancel order
GET    /orders/:id/tracking     # Get real-time tracking
```

**Example Create Order:**
```json
POST /orders
{
  "items": [
    {
      "menuItemId": "507f1f77bcf86cd799439011",
      "size": "Medium",
      "quantity": 2,
      "specialInstructions": "Make it spicy"
    }
  ],
  "orderType": "delivery",
  "deliveryAddressId": "addr_123",
  "paymentMethod": "razorpay"
}

Response (201):
{
  "success": true,
  "data": {
    "orderId": "ORD-20240115-001",
    "totalAmount": 831.84,
    "orderStatus": "pending",
    "estimatedDeliveryTime": "2024-01-15T11:45:00Z"
  }
}
```

---

### 4️⃣ PAYMENT ENDPOINTS (4)

```
POST   /payment/create          # Create payment order
POST   /payment/verify          # Verify payment
GET    /payment/methods         # Get payment methods
POST   /payment/methods         # Add new payment method
```

**Example Verify Payment:**
```json
POST /payment/verify
{
  "orderId": "ORD-20240115-001",
  "razorpayPaymentId": "pay_IluGWxBm9U8zJ8",
  "razorpayOrderId": "order_IluGWxBm9U8zJ8",
  "razorpaySignature": "signature_string"
}

Response (200):
{
  "success": true,
  "message": "Payment verified successfully",
  "data": {
    "orderId": "ORD-20240115-001",
    "paymentStatus": "completed"
  }
}
```

---

### 5️⃣ USER ENDPOINTS (9)

```
GET    /users/profile           # Get user profile
PUT    /users/profile           # Update profile
GET    /users/addresses         # Get saved addresses
POST   /users/addresses         # Add address
PUT    /users/addresses/:id     # Update address
DELETE /users/addresses/:id     # Delete address
GET    /users/favorites         # Get favorite items
POST   /users/favorites         # Add to favorites
DELETE /users/favorites/:id     # Remove favorite
```

---

### 6️⃣ REVIEW ENDPOINTS (2)

```
POST   /reviews                 # Create review
GET    /items/:id/reviews       # Get item reviews
```

---

### 7️⃣ PROMO ENDPOINTS (2)

```
GET    /promos                  # Get active promos
POST   /promos/validate         # Validate promo code
```

---

### 8️⃣ ADMIN ENDPOINTS (6)

```
GET    /admin/dashboard         # Dashboard stats
GET    /admin/orders            # Get all orders
PUT    /admin/orders/:id        # Update order status
POST   /admin/menu              # Add menu item
PUT    /admin/menu/:id          # Update menu item
GET    /admin/reports           # Get analytics/reports
```

---

## 📊 ERROR RESPONSE FORMAT

```json
{
  "success": false,
  "message": "Human-readable error message",
  "code": "ERROR_CODE",
  "statusCode": 400,
  "timestamp": "2024-01-15T11:15:00Z"
}
```

### Common Error Codes

| Code | HTTP | Meaning |
|------|------|---------|
| `INVALID_REQUEST` | 400 | Request body invalid |
| `VALIDATION_ERROR` | 400 | Input validation failed |
| `EMAIL_EXISTS` | 400 | Email already registered |
| `INVALID_CREDENTIALS` | 401 | Wrong email/password |
| `TOKEN_EXPIRED` | 401 | JWT token expired |
| `UNAUTHORIZED` | 401 | No valid token |
| `FORBIDDEN` | 403 | No permission |
| `NOT_FOUND` | 404 | Resource not found |
| `RATE_LIMITED` | 429 | Too many requests |
| `SERVER_ERROR` | 500 | Internal error |

---

## 🔄 Real-time Updates (Socket.io)

```javascript
// Subscribe to order updates
socket.emit('subscribe', { orderId: 'ORD-20240115-001' })

// Receive order status update
socket.on('orderStatusUpdate', {
  orderId: 'ORD-20240115-001',
  status: 'preparing',
  timestamp: '2024-01-15T11:20:00Z'
})

// Receive delivery tracking
socket.on('orderDeliveryTracking', {
  orderId: 'ORD-20240115-001',
  deliveryPartner: {
    name: 'Raj',
    location: { lat: 28.6139, lng: 77.2090 },
    eta: '2024-01-15T11:42:00Z'
  }
})
```

---

## 🧪 TESTING THE API

### Using cURL

```bash
# Register
curl -X POST http://localhost:5000/api/v1/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "firstName": "John",
    "email": "john@example.com",
    "password": "SecurePassword123"
  }'

# Login
curl -X POST http://localhost:5000/api/v1/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "john@example.com",
    "password": "SecurePassword123"
  }'

# Get Menu (with token)
curl -X GET http://localhost:5000/api/v1/menu/items \
  -H "Authorization: Bearer <ACCESS_TOKEN>"
```

### Using Flutter (Dio) ⭐ UPDATED

```dart
import 'package:dio/dio.dart';

final dio = Dio(
  BaseOptions(
    baseUrl: 'http://localhost:5000/api/v1',
    contentType: Headers.jsonContentType,
  ),
);

// Add token interceptor
dio.interceptors.add(
  InterceptorsWrapper(
    onRequest: (options, handler) {
      final token = localStorage.getToken();
      if (token != null) {
        options.headers['Authorization'] = 'Bearer $token';
      }
      return handler.next(options);
    },
  ),
);

// Register
Future<void> register(String email, String password) async {
  try {
    final response = await dio.post(
      '/auth/register',
      data: {
        'firstName': 'John',
        'email': email,
        'password': password,
      },
    );
    print('Registered: ${response.data}');
  } catch (e) {
    print('Error: $e');
  }
}

// Get menu
Future<List> getMenu() async {
  try {
    final response = await dio.get('/menu/items');
    return response.data['data']['items'];
  } catch (e) {
    print('Error: $e');
    rethrow;
  }
}

// Create order
Future<void> createOrder(List<Map> items, String addressId) async {
  try {
    final response = await dio.post(
      '/orders',
      data: {
        'items': items,
        'orderType': 'delivery',
        'deliveryAddressId': addressId,
        'paymentMethod': 'razorpay',
      },
    );
    print('Order created: ${response.data}');
  } catch (e) {
    print('Error: $e');
    rethrow;
  }
}
```

### Using JavaScript/React

```javascript
import axios from 'axios'

const API = axios.create({
  baseURL: 'http://localhost:5000/api/v1',
  headers: {
    'Content-Type': 'application/json'
  }
})

// Add token to requests
API.interceptors.request.use(config => {
  const token = localStorage.getItem('accessToken')
  if (token) {
    config.headers.Authorization = `Bearer ${token}`
  }
  return config
})

// Register
const register = async (email, password) => {
  const response = await API.post('/auth/register', { email, password })
  localStorage.setItem('accessToken', response.data.token.accessToken)
  return response.data
}

// Get menu
const getMenu = async () => {
  const response = await API.get('/menu/items')
  return response.data
}

// Create order
const createOrder = async (orderData) => {
  const response = await API.post('/orders', orderData)
  return response.data
}
```

---

## 📚 POSTMAN SETUP

1. Import Postman collection from project repo
2. Create environment variables:
   - `base_url`: http://localhost:5000/api/v1
   - `token`: (updated after login)
3. Use pre-made requests in folders

---

**API is production-ready and fully documented! 🚀**
