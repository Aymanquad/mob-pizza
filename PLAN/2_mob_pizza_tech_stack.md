# MOB PIZZA - Technical Architecture & Stack (Updated with Flutter)

## Executive Summary
**Project:** Mob Pizza - Multi-platform Food Ordering System
**Stack Type:** Full Stack MERN + Flutter (Free & Open Source)
**Deployment:** Free tier hosting (Firebase/Vercel/Railway)
**Database:** MongoDB (Free tier available)
**Mobile:** Flutter + Dart (100% free builds via GitHub Actions)
**Cost:** $0/month for MVP phase (100% free tier)

---

## 1. TECH STACK OVERVIEW

### 1.1 High-Level Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                     FRONTEND LAYER                          │
├──────────────────┬──────────────────┬──────────────────┐
│ Flutter App       │  React Web App    │  React Admin    │
│ (iOS/Android)    │  (Web Platform)   │  (Dashboard)    │
└──────────────────┴──────────────────┴──────────────────┘
         ↓                    ↓                   ↓
┌─────────────────────────────────────────────────────────────┐
│                   STATE MANAGEMENT                          │
│  Riverpod (Flutter) / Redux (React) / Context API          │
└─────────────────────────────────────────────────────────────┘
         ↓
┌─────────────────────────────────────────────────────────────┐
│              API LAYER (Dio / Axios)                        │
│         REST APIs with JWT Authentication                   │
└─────────────────────────────────────────────────────────────┘
         ↓
┌─────────────────────────────────────────────────────────────┐
│                BACKEND (Node.js/Express)                    │
│     Business Logic, Auth, Order Management                  │
└─────────────────────────────────────────────────────────────┘
         ↓
┌─────────────────────────────────────────────────────────────┐
│                  DATABASE LAYER                             │
│            MongoDB (Cloud Free Tier)                        │
└─────────────────────────────────────────────────────────────┘
         ↓
┌─────────────────────────────────────────────────────────────┐
│              EXTERNAL SERVICES (APIs)                       │
│    Payment, Maps, Notifications, Email                      │
└─────────────────────────────────────────────────────────────┘
```

---

## 2. DETAILED TECH STACK

### 2.1 Frontend Technologies

#### Mobile App (Flutter + Dart) ⭐ UPDATED
```
Framework:           Flutter 3.x
Language:            Dart
State Management:    Riverpod (Provider pattern)
Navigation:          Go Router (modern routing)
HTTP Client:         Dio (Axios equivalent)
Maps:               Google Maps Flutter SDK
Notifications:      Firebase Cloud Messaging (FCM)
Authentication:     Flutter Secure Storage
Payment:            Razorpay Flutter SDK
Styling:            Material Design 3
Forms:              Reactive Forms
Local Database:     SQLite / Hive
Image Handling:     Image Picker + Cached Network Image
JSON Parsing:       JSON Serializable / Freezed
Build System:       GitHub Actions (free, unlimited)
```

#### Web Application (React)
```
Framework:           React 18+
Build Tool:          Vite (Lightning fast, free)
State Management:    Redux Toolkit + Redux Thunk
Routing:             React Router v6
HTTP Client:         Axios
Maps:               Leaflet / React-Leaflet (Free, open-source)
UI Components:      Material-UI / Chakra UI (Free)
Styling:            Tailwind CSS (Free)
Forms:              React Hook Form
Authentication:     JWT + localStorage
Payment:            Razorpay Web (Free for testing)
Charts/Analytics:   Recharts / Chart.js (Free)
```

#### Admin Dashboard (React)
```
Framework:           React 18+
Build Tool:          Vite
UI Framework:       Material-UI / Ant Design (Free)
State Management:    Redux Toolkit
Charts:             Recharts
Data Tables:        TanStack React Table
Authentication:     JWT
Routing:            React Router v6
```

### 2.2 Backend Technology

```
Runtime:             Node.js 18+ LTS
Framework:           Express.js (Minimal, flexible, free)
API Type:            REST with JSON
Authentication:      JWT (jsonwebtoken library)
Password Hashing:    bcryptjs (Free)
Validation:          Joi / Yup
Environment Config:  dotenv
CORS:                cors middleware
Logging:             Winston / Pino (Free)
Rate Limiting:       express-rate-limit (Free)
Error Handling:      Custom error middleware
Caching:             Redis (free tier option)
```

### 2.3 Database

```
Primary DB:          MongoDB (Cloud - Atlas Free Tier)
  - Storage: 512 MB
  - Connections: 100 max
  - Scalable when needed
  
Connection:          Mongoose ODM (Free)
  - Schema validation
  - Middleware support
  - Indexing
  
Backup:              MongoDB Atlas automatic backups
Cache Layer:         Redis (Optional, free tier available)
```

### 2.4 Authentication & Security

```
JWT Library:         jsonwebtoken
Password Security:   bcryptjs
Environment Vars:    dotenv
HTTPS:               Automatic (modern platforms)
CORS:                cors middleware
Rate Limiting:       express-rate-limit
Input Validation:    joi / yup
```

### 2.5 External Services (All with Free Tiers)

| Service | Purpose | Free Tier |
|---------|---------|-----------|
| **Razorpay** | Payment Processing | $0 - No monthly fee, 2% + ₹3 per transaction |
| **Firebase** | Cloud Functions, Hosting, Analytics | 125k invocations/month, FCM free |
| **Resend** | Email Notifications | 3,000 emails/month free |
| **Twilio** | SMS Notifications | $15 free credit/month |
| **Google Maps API** | Maps & Geolocation | $200 free credit/month |
| **Cloudflare R2 + Images** | Object storage + image delivery | ~10 GB storage + generous free egress |
| **Socket.io** | Real-time Updates | Free (self-hosted) |
| **GitHub Actions** | CI/CD (Flutter builds) | 2,000 min/month free |

---

## 3. FOLDER & FILE STRUCTURE

### 3.1 Backend Folder Structure

```
mob-pizza-backend/
├── src/
│   ├── config/
│   │   ├── database.js
│   │   ├── email.js
│   │   ├── payment.js
│   │   └── storage.js
│   ├── models/
│   │   ├── User.js
│   │   ├── MenuItem.js
│   │   ├── Order.js
│   │   ├── Address.js
│   │   ├── Review.js
│   │   ├── Promo.js
│   │   ├── DeliveryPartner.js
│   │   └── Restaurant.js
│   ├── controllers/
│   │   ├── auth.controller.js
│   │   ├── menu.controller.js
│   │   ├── order.controller.js
│   │   ├── payment.controller.js
│   │   ├── user.controller.js
│   │   ├── address.controller.js
│   │   ├── review.controller.js
│   │   ├── delivery.controller.js
│   │   └── admin.controller.js
│   ├── routes/
│   │   ├── auth.routes.js
│   │   ├── menu.routes.js
│   │   ├── order.routes.js
│   │   ├── payment.routes.js
│   │   ├── user.routes.js
│   │   ├── address.routes.js
│   │   ├── review.routes.js
│   │   ├── delivery.routes.js
│   │   └── admin.routes.js
│   ├── middleware/
│   │   ├── auth.middleware.js
│   │   ├── errorHandler.js
│   │   ├── validation.js
│   │   ├── rateLimiter.js
│   │   └── corsConfig.js
│   ├── services/
│   │   ├── authService.js
│   │   ├── orderService.js
│   │   ├── paymentService.js
│   │   ├── emailService.js
│   │   ├── smsService.js
│   │   ├── locationService.js
│   │   └── imageService.js
│   ├── utils/
│   │   ├── validators.js
│   │   ├── helpers.js
│   │   ├── constants.js
│   │   ├── logger.js
│   │   └── responses.js
│   ├── seeders/
│   │   ├── seedMenu.js
│   │   ├── seedUsers.js
│   │   └── seedPromos.js
│   └── index.js
├── .env.example
├── .gitignore
├── package.json
├── README.md
└── server.js
```

### 3.2 Frontend - Web App Structure

```
mob-pizza-web/
├── public/
│   ├── images/
│   ├── icons/
│   └── index.html
├── src/
│   ├── components/
│   │   ├── common/
│   │   ├── layout/
│   │   ├── auth/
│   │   ├── home/
│   │   ├── menu/
│   │   ├── cart/
│   │   ├── checkout/
│   │   ├── orders/
│   │   ├── profile/
│   │   └── admin/
│   ├── pages/
│   ├── hooks/
│   ├── services/
│   ├── store/
│   ├── styles/
│   ├── utils/
│   ├── App.jsx
│   └── index.jsx
├── .env.example
├── .gitignore
├── vite.config.js
├── package.json
├── tailwind.config.js
└── README.md
```

### 3.3 Frontend - Mobile App Structure (Flutter) ⭐ UPDATED

```
mob-pizza-flutter/
├── lib/
│   ├── main.dart                          # Entry point
│   ├── config/
│   │   ├── constants.dart
│   │   ├── theme.dart
│   │   └── app_router.dart
│   ├── models/
│   │   ├── user_model.dart
│   │   ├── menu_item_model.dart
│   │   ├── order_model.dart
│   │   ├── address_model.dart
│   │   ├── review_model.dart
│   │   └── promo_model.dart
│   ├── providers/
│   │   ├── auth_provider.dart
│   │   ├── menu_provider.dart
│   │   ├── cart_provider.dart
│   │   ├── order_provider.dart
│   │   ├── user_provider.dart
│   │   └── ui_provider.dart
│   ├── services/
│   │   ├── api_service.dart
│   │   ├── auth_service.dart
│   │   ├── order_service.dart
│   │   ├── menu_service.dart
│   │   ├── payment_service.dart
│   │   ├── location_service.dart
│   │   ├── notification_service.dart
│   │   ├── storage_service.dart
│   │   └── image_service.dart
│   ├── screens/
│   │   ├── auth/
│   │   │   ├── splash_screen.dart
│   │   │   ├── sign_in_screen.dart
│   │   │   ├── sign_up_screen.dart
│   │   │   └── forgot_password_screen.dart
│   │   ├── home/
│   │   │   ├── home_screen.dart
│   │   │   └── search_screen.dart
│   │   ├── menu/
│   │   │   ├── menu_list_screen.dart
│   │   │   ├── item_detail_screen.dart
│   │   │   └── reviews_screen.dart
│   │   ├── cart/
│   │   │   └── cart_screen.dart
│   │   ├── checkout/
│   │   │   ├── checkout_screen.dart
│   │   │   ├── address_selection_screen.dart
│   │   │   ├── payment_screen.dart
│   │   │   └── order_confirmation_screen.dart
│   │   ├── orders/
│   │   │   ├── orders_list_screen.dart
│   │   │   ├── order_detail_screen.dart
│   │   │   └── order_tracking_screen.dart
│   │   └── profile/
│   │       ├── profile_screen.dart
│   │       ├── edit_profile_screen.dart
│   │       ├── addresses_screen.dart
│   │       ├── settings_screen.dart
│   │       └── help_screen.dart
│   ├── widgets/
│   │   ├── common/
│   │   │   ├── custom_button.dart
│   │   │   ├── custom_text_field.dart
│   │   │   ├── custom_card.dart
│   │   │   ├── custom_loader.dart
│   │   │   └── empty_state.dart
│   │   ├── home/
│   │   │   ├── promo_carousel.dart
│   │   │   ├── category_chip.dart
│   │   │   └── item_card.dart
│   │   ├── menu/
│   │   │   ├── menu_category_tab.dart
│   │   │   └── item_list_tile.dart
│   │   └── order/
│   │       ├── order_status_widget.dart
│   │       └── tracking_widget.dart
│   ├── utils/
│   │   ├── validators.dart
│   │   ├── formatters.dart
│   │   ├── logger.dart
│   │   └── extensions.dart
│   └── exceptions/
│       ├── api_exception.dart
│       └── app_exception.dart
├── assets/
│   ├── images/
│   ├── icons/
│   └── fonts/
├── test/
├── pubspec.yaml                          # Dependencies
├── pubspec.lock
├── analysis_options.yaml
└── README.md
```

### 3.4 Admin Dashboard Structure

```
mob-pizza-admin/
├── src/
│   ├── components/
│   │   ├── Sidebar.jsx
│   │   ├── Topbar.jsx
│   │   ├── DashboardCard.jsx
│   │   ├── DataTable.jsx
│   │   └── FormModal.jsx
│   ├── pages/
│   │   ├── Dashboard.jsx
│   │   ├── Orders/
│   │   ├── Menu/
│   │   ├── Customers/
│   │   ├── DeliveryPartners/
│   │   ├── Reports/
│   │   └── Settings/
│   ├── services/
│   │   └── adminService.js
│   ├── store/
│   │   └── adminSlice.js
│   └── App.jsx
├── .env.example
└── package.json
```

---

## 4. DATABASE SCHEMA (MongoDB)

### 4.1 Collections Structure

#### User Collection
```javascript
{
  _id: ObjectId,
  firstName: String,
  lastName: String,
  email: String (unique),
  phone: String (unique),
  passwordHash: String,
  profileImage: String (URL),
  role: String (enum: ['customer', 'admin', 'delivery']),
  preferences: {
    dietary: [String],
    spiceLevel: String,
    allergies: [String]
  },
  loyaltyPoints: Number,
  createdAt: Date,
  updatedAt: Date,
  isActive: Boolean,
  emailVerified: Boolean,
  phoneVerified: Boolean
}
```

#### MenuItem Collection
```javascript
{
  _id: ObjectId,
  name: String,
  description: String,
  category: String (enum),
  image: String (URL),
  basePrice: Number,
  sizes: [{
    name: String,
    price: Number,
    calories: Number
  }],
  toppings: [{
    id: String,
    name: String,
    price: Number
  }],
  isVegetarian: Boolean,
  isAvailable: Boolean,
  preparationTime: Number,
  rating: Number,
  reviews: [ObjectId],
  allergens: [String],
  createdAt: Date,
  updatedAt: Date
}
```

#### Order Collection
```javascript
{
  _id: ObjectId,
  orderId: String (unique),
  customer: ObjectId,
  items: [{
    menuItem: ObjectId,
    size: String,
    quantity: Number,
    addOns: [Object],
    specialInstructions: String,
    pricePerUnit: Number,
    total: Number
  }],
  orderType: String (enum: ['delivery', 'pickup']),
  deliveryAddress: ObjectId,
  pickupLocation: String,
  subtotal: Number,
  deliveryCharges: Number,
  tax: Number,
  discount: Number,
  promoCode: String,
  totalAmount: Number,
  paymentMethod: String,
  paymentStatus: String (enum: ['pending', 'completed', 'failed']),
  orderStatus: String (enum),
  deliveryPartner: ObjectId,
  estimatedDeliveryTime: Date,
  actualDeliveryTime: Date,
  customerNotes: String,
  rating: Number,
  review: String,
  createdAt: Date,
  updatedAt: Date
}
```

#### Address Collection
```javascript
{
  _id: ObjectId,
  user: ObjectId,
  label: String (enum: ['home', 'office', 'other']),
  street: String,
  city: String,
  state: String,
  zipCode: String,
  coordinates: {
    type: String (enum: ['Point']),
    coordinates: [Number, Number]
  },
  isDefault: Boolean,
  instructions: String,
  createdAt: Date,
  updatedAt: Date
}
```

#### Review Collection
```javascript
{
  _id: ObjectId,
  item: ObjectId,
  user: ObjectId,
  order: ObjectId,
  rating: Number (1-5),
  comment: String,
  images: [String],
  isVerifiedPurchase: Boolean,
  helpful: Number,
  createdAt: Date,
  updatedAt: Date
}
```

#### Promo Collection
```javascript
{
  _id: ObjectId,
  code: String (unique),
  discountType: String (enum: ['percentage', 'fixed']),
  discountValue: Number,
  minOrderValue: Number,
  maxDiscount: Number,
  usageLimit: Number,
  usageCount: Number,
  validFrom: Date,
  validTo: Date,
  applicableOn: [String],
  isActive: Boolean,
  createdAt: Date
}
```

---

## 5. API ENDPOINTS (REST)

### 5.1 Authentication (6 endpoints)
```
POST   /api/v1/auth/register
POST   /api/v1/auth/login
POST   /api/v1/auth/logout
POST   /api/v1/auth/refresh-token
POST   /api/v1/auth/forgot-password
POST   /api/v1/auth/reset-password
```

### 5.2 Menu (6 endpoints)
```
GET    /api/v1/menu/items
GET    /api/v1/menu/items/:id
GET    /api/v1/menu/categories
GET    /api/v1/menu/search
GET    /api/v1/menu/featured
GET    /api/v1/menu/deals
```

### 5.3 Orders (6 endpoints)
```
POST   /api/v1/orders
GET    /api/v1/orders
GET    /api/v1/orders/:id
PUT    /api/v1/orders/:id
DELETE /api/v1/orders/:id
GET    /api/v1/orders/:id/tracking
```

### 5.4 Payment (4 endpoints)
```
POST   /api/v1/payment/create
POST   /api/v1/payment/verify
GET    /api/v1/payment/methods
POST   /api/v1/payment/methods
```

### 5.5 User (9 endpoints)
```
GET    /api/v1/users/profile
PUT    /api/v1/users/profile
GET    /api/v1/users/addresses
POST   /api/v1/users/addresses
PUT    /api/v1/users/addresses/:id
DELETE /api/v1/users/addresses/:id
GET    /api/v1/users/favorites
POST   /api/v1/users/favorites
DELETE /api/v1/users/favorites/:id
```

### 5.6 Reviews (2 endpoints)
```
POST   /api/v1/reviews
GET    /api/v1/items/:id/reviews
```

### 5.7 Promos (2 endpoints)
```
GET    /api/v1/promos
POST   /api/v1/promos/validate
```

### 5.8 Admin (6 endpoints)
```
GET    /api/v1/admin/dashboard
GET    /api/v1/admin/orders
PUT    /api/v1/admin/orders/:id
POST   /api/v1/admin/menu
PUT    /api/v1/admin/menu/:id
GET    /api/v1/admin/reports
```

**Total: 40+ endpoints**

---

## 6. EXTERNAL INTEGRATIONS

### 6.1 Payment Gateway - Razorpay
```
Cost: 2% + ₹3 per successful transaction (only on collected amount)
Integration: Both Flutter & Web supported
Testing: Free sandbox mode available
```

### 6.2 Location Services - Google Maps
```
Used for: Geocoding, distance calculation, autocomplete
Free tier: $200/month credit
```

### 6.3 Email - Resend
```
Used for: Order confirmation, status updates, password reset
Free tier: 3,000 emails/month
```

### 6.4 SMS - Twilio
```
Used for: OTP, order status, promotions
Free tier: $15 credit/month
```

### 6.5 Push Notifications - Firebase FCM
```
Used for: Order updates, promotions, alerts
Free tier: 1 million messages/month
```

### 6.6 Image Storage - Cloudflare R2 + Images
```
Used for: Food images, user uploads
Free tier: ~10 GB storage, Images CDN handles delivery/optimization
Alternative: Cloudinary (if you need built-in transformations)
```

---

## 7. DEPLOYMENT ARCHITECTURE

### 7.1 Backend Deployment

```
Platform: Render
├── Free web service tier (sleeps on inactivity)
├── GitHub integration
├── Simple scaling to paid if needed
└── Automatic deploys from main branch
```

### 7.2 Frontend Deployment

#### Web App
```
Platform: Vercel
├── Free tier: Unlimited
├── GitHub integration
└── Automatic deployments
```

#### Mobile App (Flutter) ⭐ UPDATED
```
Build System: GitHub Actions (FREE)
├── 2,000 minutes/month free
├── Unlimited builds
├── No queue waiting
├── Build time: 5-10 minutes

Distribution:
├── Google Play Store: $25 (one-time)
├── Apple App Store: $99/year
└── Total: $124/year for both stores
```

#### Admin Dashboard
```
Platform: Vercel
├── Free tier: Unlimited
└── GitHub integration
```

### 7.3 Database Deployment

```
Platform: MongoDB Atlas
├── Free tier: 512 MB storage
├── Auto backups
├── 100 concurrent connections
└── Auto-scaling when needed
```

### 7.4 Complete Deployment Stack (FREE for MVP)

```
┌─────────────────────────────────────────┐
│ Frontend (Vercel)                       │
│ - React Web App                         │
│ - Admin Dashboard                       │
│ Cost: FREE                              │
└─────────────────────────────────────────┘
           ↓
┌─────────────────────────────────────────┐
│ Mobile (GitHub Actions)                 │
│ - Flutter App (iOS/Android)             │
│ Cost: FREE (unlimited builds)           │
└─────────────────────────────────────────┘
           ↓
┌─────────────────────────────────────────┐
│ Backend (Render)                        │
│ - Node.js/Express API                   │
│ Cost: FREE tier (sleeps), upgrade as needed │
└─────────────────────────────────────────┘
           ↓
┌─────────────────────────────────────────┐
│ Database (MongoDB Atlas)                │
│ - MongoDB Cloud Free Tier               │
│ Cost: FREE (512 MB)                     │
└─────────────────────────────────────────┘

External Services
├── Razorpay: $0/month + transaction fee
├── Resend: FREE (3,000 emails/month)
├── Google Maps: $200/month free credit
├── Firebase: FREE (1M messages)
└── Total: $0/month + transaction fees

🎉 TOTAL COST FOR MVP: $0-5/month
   APP STORES: $124/year
```

---

## 8. DEVELOPMENT SETUP GUIDE

### 8.1 Backend Setup

```bash
git clone repo
cd mob-pizza-backend
npm install
cp .env.example .env
npm run seed
npm run dev
# Server: http://localhost:5000
```

### 8.2 Frontend Web Setup

```bash
git clone repo
cd mob-pizza-web
npm install
cp .env.example .env.local
npm run dev
# App: http://localhost:5173
```

### 8.3 Frontend Mobile Setup (Flutter) ⭐ UPDATED

```bash
git clone repo
cd mob-pizza-flutter
flutter pub get
cp .env.example .env
flutter run
# Or: flutter run -d <device_id>
```

### 8.4 Admin Dashboard Setup

```bash
git clone repo
cd mob-pizza-admin
npm install
npm run dev
# Admin: http://localhost:5174
```

---

## 9. 16-WEEK TIMELINE

### Phase 1: Planning & Design (Weeks 1-4)
- Week 1: Finalize specifications ✓ DONE
- Week 2: Create Figma designs & prototypes
- Week 3: Design review & refinements
- Week 4: Finalize all design assets

### Phase 2: Backend Development (Weeks 5-8)
- Week 5: Authentication & database setup
- Week 6: Menu & Order APIs
- Week 7: Payment & notification integration
- Week 8: Testing & optimization

### Phase 3: Frontend Development (Weeks 9-13)
- Week 9: Web app setup & Flutter project init
- Week 10-11: Menu & cart flow (web + mobile parallel)
- Week 12: Checkout & order tracking (web + mobile)
- Week 13: Mobile app polish & optimization

### Phase 4: Integration & Testing (Weeks 14-15)
- Week 14: Full end-to-end testing
- Week 15: Performance optimization & bug fixes

### Phase 5: Launch (Week 16)
- Deploy to production
- Setup monitoring
- Launch marketing
- Go live! 🎉

---

## 10. SECURITY CHECKLIST

- [ ] JWT authentication with secure tokens
- [ ] Password hashing (bcryptjs)
- [ ] HTTPS/SSL everywhere
- [ ] CORS properly configured
- [ ] Input validation on all endpoints
- [ ] Rate limiting enabled
- [ ] Injection prevention
- [ ] XSS protection
- [ ] CSRF tokens
- [ ] Secure headers (Helmet.js)
- [ ] Environment variables never in code
- [ ] API keys rotated regularly
- [ ] PCI compliance for payments
- [ ] GDPR compliance for user data
- [ ] Regular security audits

---

## 11. FINAL NOTES

This technical stack is:
✅ **100% FREE for MVP** with zero licensing costs
✅ **Scalable** to handle thousands of orders
✅ **Modern** using latest technologies
✅ **Flexible** easy to modify and extend
✅ **Production-ready** with security & performance
✅ **Well-documented** for easy onboarding
✅ **Cloud-native** deployed on free services

**Total MVP Cost: $0-5/month + $124/year for app stores**

Ready to build! 🚀
