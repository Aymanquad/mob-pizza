# MOB PIZZA - Project Overview & Quick Reference (Updated with Flutter)

## 📋 PROJECT SUMMARY

**Project:** Mob Pizza - Multi-platform Pizza Restaurant App & Website
**Type:** Multi-platform Food Ordering System (App + Website)
**Platforms:** 
- 📱 Mobile App (iOS & Android via Flutter)
- 🌐 Web Platform (React + Vite)
- 👨‍💼 Admin Dashboard (React)

**Timeline:** 16 weeks for complete MVP
**Cost:** $0-5/month operating + $124/year for app stores

---

## 🎯 CORE FEATURES AT A GLANCE

### User Features (13)
✅ User registration & authentication
✅ Browse pizza menu with search & filters
✅ Customize orders (crust, toppings, sauce)
✅ Add items to cart
✅ Delivery or Pickup options
✅ Multiple payment methods (Card, UPI, Wallet, COD)
✅ Real-time order tracking with map
✅ Order history & quick reorder
✅ Favorites/Wishlist
✅ User profile & address management
✅ Reviews & ratings
✅ Push notifications
✅ Loyalty points system

### Admin Features (8)
✅ Real-time order management & status updates
✅ Menu item CRUD operations
✅ Customer management
✅ Delivery partner management & tracking
✅ Analytics & revenue reports
✅ Business hours & delivery zone config
✅ Promotional campaigns
✅ Settings & configuration

---

## 📱 APP PLATFORMS BREAKDOWN

### Mobile App (Flutter)
```
Size: ~50-80 MB (smaller than Expo)
Users can:
├── Install from App Store / Play Store
├── Browse menu with offline cache
├── Place orders with location
├── Get push notifications
├── Track deliveries in real-time
└── Seamless checkout with saved addresses

Build Cost: $0/month (GitHub Actions)
```

### Web Platform (React)
```
URL: https://mobpizza.com
Users can:
├── Browse full menu
├── Order with desktop/tablet
├── See order history
├── Manage profile
└── Responsive design (mobile-friendly)

Hosting Cost: $0/month (Vercel)
```

### Admin Dashboard (React)
```
URL: https://admin.mobpizza.com
Admin can:
├── Manage all orders in real-time
├── Update menu items
├── View analytics & revenue
├── Manage delivery partners
└── Send promotional campaigns

Hosting Cost: $0/month (Vercel)
```

---

## 🏗️ ARCHITECTURE LAYERS

### 1. Frontend Layer
```
Flutter App (Dio)          →  Mobile Users (iOS/Android)
React Web App (Axios)      →  Web Users (Desktop/Mobile)
React Admin App (Axios)    →  Restaurant Owner
           ↓
All connected via REST APIs with JWT authentication
```

### 2. State Management Layer
```
Riverpod (Flutter - Recommended)
├── Auth state
├── Cart state
├── Menu state
├── Order state
└── UI state

Redux Toolkit (React)
├── Same structure as above
```

### 3. API Layer
```
Express.js REST API
├── Base URL: https://api.mobpizza.com/api/v1
├── Authentication: JWT tokens
├── Request/Response: JSON
└── Error Handling: Standard HTTP codes
```

### 4. Business Logic Layer
```
Node.js/Express Controllers
├── Authentication logic
├── Order processing
├── Payment validation
├── Email/SMS sending
├── Real-time tracking
└── Analytics
```

### 5. Database Layer
```
MongoDB Atlas (Cloud)
├── 8 collections (Users, Items, Orders, etc.)
├── 100 max concurrent connections
├── 512 MB free tier
└── Auto-scaling support
```

---

## 📊 DATA FLOW EXAMPLE

```
USER PLACES ORDER
      ↓
[Flutter/React Frontend]
- Select items
- Add to cart
- Enter address
- Select payment
      ↓
[Frontend calls POST /api/v1/orders]
      ↓
[Express.js Backend]
- Validate order
- Create in MongoDB
- Calculate total
      ↓
[Frontend calls POST /api/v1/payment/verify]
      ↓
[Razorpay processes payment]
      ↓
[Backend sends email + SMS]
      ↓
[Admin app shows order (real-time)]
      ↓
[Customer gets order tracking]
      ↓
DELIVERY → COMPLETION ✅
```

---

## 💾 DATABASE STRUCTURE SIMPLIFIED

### Collections (Tables)
```
Users
├── name, email, phone, password
├── preferences (dietary, allergies)
└── loyaltyPoints

MenuItems
├── name, description, image
├── category (Pizza, Combo, Side, Beverage)
├── sizes (S/M/L with prices)
├── toppings (add-ons)
└── isVegetarian, isAvailable

Orders
├── customerId, items, totalAmount
├── orderType (delivery/pickup)
├── orderStatus (pending/preparing/delivered)
├── paymentStatus
└── createdAt, updatedAt

Addresses
├── userId, street, city, state
├── coordinates (lat/long)
├── label (home/office)
└── isDefault

Reviews
├── itemId, userId, rating
├── comment, images
└── createdAt

DeliveryPartners
├── name, phone, email
├── vehicleType, location
└── isAvailable

Promos
├── code, discountType, discountValue
├── validFrom/validTo
└── usageLimit
```

---

## 🔌 EXTERNAL INTEGRATIONS

### Payment Processing
**Service:** Razorpay
- User clicks "Pay" → Razorpay popup
- User enters card/UPI/wallet details
- Backend verifies payment signature
- Order confirmed

**Cost:** 2% + ₹3 per transaction (only on collected amount)

### Location Services
**Service:** Google Maps
- Show restaurant location
- Get user's current location
- Calculate delivery distance
- Suggest delivery addresses

**Cost:** FREE ($200/month credit)

### Email Notifications
**Service:** Resend
- Order confirmation
- Order status updates
- Account verification
- Password reset

**Cost:** FREE (3,000 emails/month)

### SMS Notifications
**Service:** Twilio
- OTP for phone verification
- Order status SMS
- Promotional SMS

**Cost:** FREE ($15 credit/month)

### Push Notifications
**Service:** Firebase Cloud Messaging
- Send to mobile app users
- Order status updates
- Promotional notifications

**Cost:** FREE (1M messages/month)

### Image Storage (Optional)
**Service:** Cloudflare R2 + Images
- Upload food images
- CDN delivery/optimization via Images
- Simple object storage in R2

**Cost:** FREE (~10 GB storage + generous egress)

---

## 🚀 DEPLOYMENT TARGETS

### Backend API
**Platform:** Render
- Free web service tier (sleeps on inactivity)
- Node.js support
- GitHub deployment
- Easy scaling to paid if needed

**API URL:** `https://api.mobpizza.com`

### Web App
**Platform:** Vercel
- Free tier: Unlimited
- React/Vite optimized
- Automatic deployments
- Global CDN

**Web URL:** `https://mobpizza.com`

### Admin Dashboard
**Platform:** Vercel (same as web app)
**Admin URL:** `https://admin.mobpizza.com`

### Database
**Platform:** MongoDB Atlas
- Free tier: 512 MB storage
- Auto backups
- Auto-scaling support

### Mobile App (Flutter) ⭐ UPDATED
**Building:** GitHub Actions (FREE - unlimited)
**Distribution:** 
- Google Play Store: $25 (one-time)
- Apple App Store: $99/year

**Total Cost:** $124/year for both stores

---

## 📈 ESTIMATED METRICS

### Performance Targets
- Page load time: < 2 seconds
- API response time: < 500ms
- App startup time: < 2 seconds (Flutter)
- Lighthouse score: 90+

### Scale Metrics (MVP)
- Concurrent users: 100
- Daily orders: 50-100
- Database size: < 100 MB
- App size: 50-80 MB (Flutter, smaller than Expo)
- Web app bundle: < 200 KB (gzipped)

---

## 🛠️ TECH STACK SUMMARY TABLE

| Layer | Technology | Why Chosen | Cost |
|-------|-----------|-----------|------|
| **Mobile Frontend** | **Flutter + Dart** | Native perf, fast builds, free CI/CD | $0/month |
| **Web Frontend** | React + Vite | Fast, modern, good ecosystem | $0/month |
| **Admin Dashboard** | React + Vite | Same as web, easy to manage | $0/month |
| **Backend** | Node.js + Express | Lightweight, JavaScript everywhere | $0-5/month |
| **Database** | MongoDB | Flexible, free tier 512 MB | $0/month |
| **Authentication** | JWT | Stateless, secure, scalable | $0/month |
| **Payment** | Razorpay | Indian payments, free testing | 2% + ₹3 |
| **Maps** | Google Maps | Standard, reliable | $200 free/month |
| **CI/CD** | GitHub Actions | Free unlimited Flutter builds | $0/month |
| **App Stores** | Play + App Store | Distribution | $124/year |
| **Hosting** | Render (API) + Vercel (web/admin) | Fast, easy scaling | $0-5/month |

**Total MVP Cost: $0-5/month + $124/year for app stores**

---

## 📅 DEVELOPMENT WORKFLOW

### Week 1-4: Planning & Design
```
Day 1-5:    Finalize specifications ✓ DONE
Day 6-10:   Create Figma mockups
Day 11-15:  Design review & refinements
Day 16-20:  Finalize design assets
```

### Week 5-8: Backend Development
```
Week 5:     User auth, database setup
Week 6:     Menu & order APIs
Week 7:     Payment & notifications
Week 8:     Testing & optimization
```

### Week 9-13: Frontend Development
```
Week 9:     Web setup + Flutter project init
Week 10-11: Menu & cart (web + mobile parallel)
Week 12:    Checkout & tracking (web + mobile)
Week 13:    Mobile polish & optimization
```

### Week 14-15: Integration & Testing
```
Week 14:    Full end-to-end testing
Week 15:    Performance optimization
```

### Week 16: Launch
```
Deploy to production
Setup monitoring
Launch marketing
Go live! 🎉
```

---

## ✅ PRE-LAUNCH CHECKLIST

### Backend
- [ ] All API endpoints tested
- [ ] Authentication working
- [ ] Payment integration verified
- [ ] Error handling complete
- [ ] Rate limiting enabled
- [ ] Database backups working
- [ ] Logging configured
- [ ] Security headers set

### Frontend (Web)
- [ ] All pages responsive
- [ ] All features functional
- [ ] Images optimized
- [ ] Performance tested (90+)
- [ ] Accessibility tested
- [ ] Cross-browser tested
- [ ] Mobile responsive
- [ ] Error states handled

### Mobile (Flutter)
- [ ] iOS build tested
- [ ] Android build tested
- [ ] Push notifications working
- [ ] Location services working
- [ ] Offline mode working
- [ ] App icons/splash ready
- [ ] Privacy policy included
- [ ] Terms accepted

### Deployment
- [ ] Domain names registered
- [ ] SSL certificates installed
- [ ] CI/CD pipeline setup
- [ ] Monitoring configured
- [ ] Error tracking setup
- [ ] Analytics configured
- [ ] Backups automated
- [ ] Support channels ready

---

## 🎓 LEARNING RESOURCES

### Flutter Learning
- https://flutter.dev/docs - Official docs
- https://dart.dev - Dart language
- https://codewithandrea.com - Best practices

### React Learning
- https://react.dev - Official docs
- https://redux-toolkit.js.org - Redux
- https://vitejs.dev - Vite

### Backend Learning
- https://expressjs.com - Express
- https://nodejs.org/docs - Node.js
- https://docs.mongodb.com - MongoDB

### Deployment
- https://railway.app/docs - Railway
- https://vercel.com/docs - Vercel
- https://docs.atlas.mongodb.com - MongoDB Atlas

---

## 🤝 TEAM STRUCTURE RECOMMENDATION

### For MVP (4-6 people)
1. **Backend Developer (1)** - Node.js/MongoDB
2. **React Developer (1)** - Web + Admin
3. **Flutter Developer (1)** - iOS & Android
4. **Designer/UI (1)** - Figma designs
5. **DevOps/QA (1)** - Deployment, testing
6. **Project Manager (0.5)** - Timeline, communication

---

## 💡 FLUTTER ADVANTAGES OVER EXPO

✅ **Unlimited free builds** (GitHub Actions)
✅ **Faster build time** (5-10 min vs 15-20 min)
✅ **Smaller app size** (50-80 MB vs 120-150 MB)
✅ **Better performance** (native Dart)
✅ **No build queue** (always available)
✅ **$4,000+/year cost savings**

---

## 🎉 SUMMARY

You have everything needed to:
- ✅ Build Mob Pizza from scratch
- ✅ Deploy to production
- ✅ Scale to thousands of orders
- ✅ Launch on both app stores
- ✅ Save $4,000+/year with Flutter

**Ready to build! 🚀**
