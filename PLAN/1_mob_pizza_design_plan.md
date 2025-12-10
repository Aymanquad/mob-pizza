
# MOB PIZZA – Complete Design & Feature Planning (Mob-Themed, Flutter)

## Executive Overview
**Project:** Mob Pizza – Mob-themed multi-platform restaurant app & website (1920s speakeasy / mafia aesthetic).  
**Scope:** Mobile App (Flutter iOS/Android) + Web Platform (React) + Admin Dashboard.  
**MVP Timeline:** 16 weeks  
**Cost Model:** $0–5/month operating + $124/year for app stores (100% free tier)

---

## 1. FEATURE BREAKDOWN

### 1.1 Core User Features

#### Authentication & Onboarding
- **Splash Screen** – Mob Pizza logo as a vintage speakeasy sign, appearing over a dimly lit alley or back-room restaurant with a subtle fade-in (2–3 seconds).
- **Onboarding Screens** – 3–4 slides themed as “The Family Rules”, “The Hit List”, and “The Family Loyalty”, each with sepia/charcoal imagery and short copy.
- **Sign Up** – Email/Phone, password, name with “Join the Family” primary CTA.
- **Sign In** – Email/Phone + password with “Back in the Family” copy and optional “Remember Me”.
- **Forgot Password** – Recovery flow styled as “Recover Your Credentials” with subtle dossier/file visuals.
- **Social Auth** – Google Sign-In (optional for MVP), visually presented as a secondary, understated option.
- **Profile Completion** – Delivery address, phone, preferred “family orders” (favorite pizzas, spice level).

#### Home Screen / Dashboard
- **Header** – Current neighborhood shown as “Territory: [Area]”, notification bell, circular profile icon styled like a vintage portrait frame.
- **Search Bar** – Placeholder “Search the Hit List…” with magnifying glass icon in gold.
- **Promo Banner** – Carousel of “Tonight’s Specials” with noir photography and gold accents.
- **Quick Categories** – Chips like “The Boss’s Picks”, “Veg Associates”, “Meat Mafia”, “Family Combos”, “Under-the-Table Deals”.
- **Featured Items** – Section titled “The Boss Recommends” with 3–6 pizzas highlighted.
- **Recent Orders** – “Your Last Jobs” listing recent orders with quick reorder CTA.
- **Special Offers Section** – “Tonight’s Specials” cards with time-limited offers.

#### Menu & Browsing
- **Menu Categories** (themed labels, same structure):
  - Boss Pies (signature pizzas)
  - Family Combos (pizza + sides + drink)
  - Side Hustles (sides)
  - Liquid Alibis (beverages & desserts)
  - Under-the-Table Deals (promos)
- **Item Card Display**
  - Card styled as a “case file” with image, name, alias, brief description, rating, price
  - Vegetarian/Non-Veg indicator
  - Quick “Add to Hit List” button (add to cart)
- **Item Detail Page**
  - Large hero image in dim lighting with vignette
  - Item name + mob alias (e.g., “Margherita – The Mistress”)
  - Story snippet: short, in-world description (“Thin crust trusted by the Don since 1928”)
  - Size options (Solo, Crew, Family – mapped to Small, Medium, Large)
  - Customization options:
    - Crust: Street Thin, Regular, Brick Oven Thick, Stuffed Boss Crust
    - Sauce: Red Marinara, White Truffle, Pesto Hit, Smoky BBQ
    - Extra Toppings: grouped under “Add More Trouble”
    - Extra Cheese options
    - Special Instructions: input labeled “Whisper to the Kitchen”
  - Quantity selector
  - “Add to Hit List” button
  - Reviews & Ratings section titled “Family Testimonies”

#### Cart & Checkout
- **Cart Screen** – Titled “Job Summary”
  - Itemized list with quantities
  - Modify/Remove options
  - Subtotal, taxes, delivery charges breakdown
  - Promo code input field labeled “Got a secret code?”
  - Primary CTA: “Proceed to The Deal”
  - Secondary: “Keep Browsing the Hit List”
  - Empty state: mob-themed illustration and “No jobs lined up yet”
- **Order Type Selection**
  - Delivery → “Family Delivery” with car icon
  - Pickup → “Safehouse Pickup” with storefront icon
- **Delivery Address Management**
  - List saved addresses
  - Add new address (with map search)
  - Address label examples: Home Base, Office Front, Safehouse
  - Delivery instructions field
  - Address verification on map
- **Payment Gateway Integration**
  - Credit/Debit Card
  - Digital Wallets (Apple Pay, Google Pay)
  - UPI (Razorpay)
  - Cash on Delivery
  - Save payment method for future jobs
- **Order Review Screen**
  - Titled “Final Briefing”
  - Order summary
  - Delivery/Pickup details (Drop Location)
  - Total amount labeled “The Take”
  - Confirm button: “Lock In the Job”

#### Order Tracking
- **My Orders Screen** – “Past Jobs”
  - List of current & past orders
  - Filters by status: Pending, Kitchen in Motion, On the Streets, Delivered, Cancelled
- **Order Detail Page**
  - Order items with quantities
  - Timeline with themed statuses: Contract Received → Kitchen in Motion → On the Streets → Delivered to You
  - Delivery/Pickup time
  - Real-time tracking map for deliveries
  - Driver details as “Your Runner” (name, phone, vehicle)
  - Customer support “Call the Front Office”
  - Re-order button “Run This Job Again”

#### User Profile & Settings
- **Profile Screen** – “Your File”
  - User name, email, phone, profile photo frame styled like a mugshot border
  - Edit profile
  - Address management
  - Payment methods
  - Preferences:
    - Dietary
    - Heat Level (Mild, Made, Turf War)
    - Allergies
  - Loyalty points/credits labeled “Family Loyalty”
  - Order summary stats (“Jobs Completed”)
- **Settings**
  - Notifications (push, SMS, email)
  - Language selection
  - Theme: dark mob theme as default (only minor adjustments for accessibility)
  - Privacy policy, terms & conditions
  - About Mob Pizza
  - Logout (“Leave the Family”)

#### Additional Features
- **Ratings & Reviews**
  - Post-delivery review prompt themed as “Tell the Neighborhood”
  - Star rating (1–5)
  - Photo upload
  - Text review
  - Option to mark as “Anonymous Tip”
- **Favorites/Wishlist**
  - “Protected Orders” – quick access list of favorite items
  - One-tap add to cart
- **Push Notifications**
  - Order status updates (“Your job just left the kitchen”)
  - Special offer alerts (“The Don has a new deal for you”)
  - New item announcements
  - Birthday discounts
- **Customer Support**
  - In-app chat (“Message the Family”)
  - FAQ section
  - Contact form
  - Call restaurant (“Call the Front Office”)
- **Loyalty Program (Future Enhancement)**
  - Ranks: Associate, Capo, Don
  - Points called “Family Points”
  - Redeemable for discounts, exclusive “closed-door events”
  - Referral rewards and birthday specials

---

## 2. WEBSITE FEATURES (Web Platform)

### 2.1 Website-Specific Screens

#### Landing Page – “The Family’s Table”
- Hero banner with dim speakeasy-style restaurant photo, neon Mob Pizza sign, dark overlay
- Main tagline: “The Family’s Slice Since 1928”
- Primary CTA: “Join the Family (Order Now)”
- About section: “The Family Business” – short mob-style backstory and sepia photo collage
- Featured items carousel: “The Hit List”
- Testimonials: “What the Neighborhood Says”
- Our specialties: “House Secrets” cards
- Current promotions: “Tonight’s Specials”
- Newsletter signup: “Get Word from the Inside”
- Contact information: “Find the Front”

#### Web Menu Page – “The Hit List”
- Full menu with mob-styled categories
- Filters by dietary preference, price range, heat level, “Boss Picks”
- Search bar: “Search the Hit List…”
- Item detail via modal styled like a dossier sheet
- Cart sidebar titled “Job Summary” (sticky)

#### Web Ordering Flow
- Menu browsing → item selection → cart → checkout
- Login/guest checkout
- Address with autocomplete
- Payment processing
- Order confirmation (“Job Confirmed”)

#### Web-Exclusive Pages
- Store locator – “Territory Map” (if multiple locations)
- About Us – “The Family Story”
- Blog – “Neighborhood Gazette”
- Catering/Party orders – “Closed-Door Events”
- Feedback/Contact – “Talk to the Front Office”

---

## 3. ADMIN PANEL FEATURES (Web-based)

### 3.1 Restaurant Owner Dashboard

#### Dashboard Overview
- Daily overview styled like a ledger:
  - Daily Take (revenue)
  - Jobs Closed (completed orders)
  - Average Take (average order value)
  - Top Hit List Items (popular pizzas)
  - Pending Jobs (open orders)

#### Order Management
- Real-time order list with filters
- Update status through theme statuses (e.g., Contract Received → Kitchen in Motion → On the Streets → Delivered)
- Prep time management
- Delivery zone configuration
- Order history & analytics

#### Menu Management
- Add/Edit/Delete items
- Category management (Boss Pies, Family Combos, etc.)
- Bulk pricing updates
- Availability toggles
- Image management

#### Staff Management
- Delivery partner management (“Runners”)
- Assign orders
- Track driver location
- Performance metrics

#### Customer Management
- Customer list
- Targeted promotions
- Loyalty rank management (Associate/Capo/Don)
- Feedback and complaint logs

#### Analytics & Reports
- Daily/weekly/monthly revenue
- Order and item trends
- Loyalty engagement
- Campaign performance

#### Settings
- Business hours
- Delivery zones
- Payment settings
- Notification settings
- API key management

---

## 4. USER FLOWS & WIREFRAMES

### 4.1 Primary User Journey – Online Ordering

[Join the Family / Sign In]
↓
[Home – The Family’s Table]
↓
[Browse The Hit List]
↓
[Select Item]
↓
[Customize (Crust, Sauce, Add More Trouble)]
↓
[Add to Hit List]
↓
[Job Summary (Cart)]
↓
[Choose Family Delivery / Safehouse Pickup]
↓
[Confirm Drop Location]
↓
[Select Payment Method]
↓
[Final Briefing (Review & Confirm)]
↓
[Job Confirmed]
↓
[Track Job]
↓
[Receive Order]
↓
[Tell the Neighborhood (Review)]

text

### 4.2 Quick Reorder Journey

[Home]
↓
[Your Last Jobs]
↓
[Select Previous Job]
↓
[Run This Job Again]
↓
[Checkout]

text

### 4.3 Search & Discovery Journey

[Home]
↓
[Search the Hit List…]
↓
[Enter Query / Apply Filters]
↓
[View Results]
↓
[Select Item]
↓
[Add to Hit List]

text

---

## 5. MOBILE APP SCREEN STRUCTURE (Flutter)

### Screens for Mobile App (35+ screens)

#### Authentication (5 screens)
1. Splash/Welcome (“Mob Pizza” speakeasy sign)
2. Sign In (“Back in the Family”)
3. Sign Up (“Join the Family”)
4. Forgot Password
5. Profile Completion (“Finish Your File”)

#### Shopping Flow (12 screens)
6. Home/The Family’s Table  
7. The Hit List (Menu listing)  
8. Item Detail & Customization  
9. Job Summary (Cart)  
10. Drop Location Selection (Delivery vs Pickup)  
11. Drop Location Entry  
12. Payment Method Selection  
13. Final Briefing (Order Review)  
14. Job Confirmed (Order Confirmation)  
15. Empty Cart State  
16. Search Results  
17. Item Search Detail  
18. Protected Orders (Favorites)

#### Order Tracking (5 screens)
19. Past Jobs (My Orders)  
20. Job Detail – Kitchen in Motion  
21. Job Detail – On the Streets  
22. Real-time Tracking Map  
23. Job History Detail

#### User Account (8 screens)
24. Your File (Profile)  
25. Edit File (Edit Profile)  
26. Safehouses (Saved Addresses)  
27. Payment Methods  
28. Family Loyalty (Points & Ranks)  
29. Settings  
30. Notification Preferences  
31. Help & Support

#### Additional (5+ screens)
32. Family Testimonies (Reviews & Ratings)  
33. FAQ / Help  
34. Filters (Heat, Category, Price)  
35. Promotions/Offers Detail (“Tonight’s Specials”)  
36. Legal / Policies (optional)

---

## 6. DESIGN SPECIFICATIONS

### 6.1 Color Palette (Mob Theme)

- **Background Primary:** `#0B0C10` – Charcoal black (main app background)
- **Background Secondary:** `#1C1512` – Deep espresso (cards, panels)
- **Primary Brand Color – Mob Red:** `#B32222` – Rich mafia red for key highlights and danger accents
- **Secondary Accent – Speakeasy Gold:** `#D9A441` – Gold for CTAs, icons, dividers
- **Highlight Accent – Whiskey Amber:** `#E98354` – Secondary CTAs, hover states
- **Muted Accent – Olive Drab:** `#919F89` – Chips, secondary borders, filters
- **Border / Lines:** `#3A3A3A`
- **Text Primary:** `#F5F3EC` – Warm off-white
- **Text Secondary:** `#C0B8A8`
- **Success:** `#4E7D4A`
- **Error:** `#8C1C1C`

### 6.2 Typography (Mob Theme)

- **Logo / Hero Headings:**
  - Font: Cinzel or Cinzel Decorative (Google Fonts)
  - All caps, letter-spacing +2–4, used for “MOB PIZZA”, “THE HIT LIST”, etc.

- **Headings (H1–H3):**
  - H1: 40–48 px, bold, uppercase, often in gold on dark background
  - H2: 28–32 px, uppercase/small caps
  - H3: 22–24 px, mixed case allowed

- **Body Text:**
  - Font: Inter or Poppins
  - Size: 14–16 px
  - Line-height: 1.6
  - Text primary for main content, text secondary for labels and helper text

- **Buttons:**
  - Font: Inter/Poppins, semi-bold
  - All caps, letter-spacing +1
  - Primary button text in near-black on gold background

- **Numbers & Prices:**
  - Font: Inter bold (or Space Grotesk if desired)
  - Emphasis as ledger-style pricing in cart and order summaries

### 6.3 Component Library (Themed)

- **Buttons (Primary, Secondary, Tertiary, Outlined):**
  - Primary: `#D9A441` background, `#0B0C10` text, soft shadow
  - Secondary: transparent background, `#D9A441` border, gold text
  - Danger: `#8C1C1C` background, off-white text

- **Cards (Item, Order, Promo):**
  - Background: `#1C1512`
  - Border: `1px solid #3A3A3A`
  - Radius: 8 px
  - Shadow: soft, dark (cinematic depth)

- **Input Fields:**
  - Dark input background, light text
  - Subtle gold focus ring and label
  - Clear error states in deep scarlet

- **Chips/Tags:**
  - Category chips: `#919F89` background, dark text
  - Status chips: colors based on success/error, small caps text

- **Badges:**
  - “BOSS PICK”, “FAMILY FAVORITE”, “HOUSE SECRET” – gold base, mob red text or border

- **Bottom Sheets & Modals:**
  - Dark surfaces, gold handle
  - Rounded top corners
  - High-contrast close icons

### 6.4 Spacing & Layout
- Base unit: 8 px  
- Padding: 8, 16, 24, 32 px  
- Margins: 8, 16, 24, 32 px  
- Grid:
  - Mobile: 4-column
  - Tablet: 8-column
  - Desktop: 12-column  
- Layout emphasizes cinematic, centered compositions for key sections, with plenty of negative space.

### 6.5 Icons & Imagery

- **Icon Set:**
  - Line icons (Material/Feather as base), customized with mob-themed glyphs where possible
  - Colors: off-white default, gold for active/primary actions

- **Photography:**
  - Dark, moody restaurant scenes
  - Warm key lighting on pizzas and drinks
  - Occasional sepia or slight grain overlays

- **App Imagery:**
  - Mob/speakeasy motif in empty states (e.g., empty cart with a “closed case” file)
  - Illustrations showing hats, cards, vintage neon signs (non-violent, stylized)

- **Animations:**
  - Subtle fades, slides, and opacity transitions
  - 200–400 ms duration
  - No aggressive motion to maintain classy vibe

---

## 7. RESPONSIVE DESIGN BREAKPOINTS

| Device  | Width      | Layout                                      |
|---------|------------|---------------------------------------------|
| Mobile  | 320–480 px | Single column, bottom nav, stacked content |
| Tablet  | 481–768 px | 2-column when possible, side navigation    |
| Desktop | 769 px+    | 3+ columns, full navigation header         |

---

## 8. ACCESSIBILITY STANDARDS

- WCAG 2.1 Level AA compliance
- Color contrast ratio 4.5:1 minimum (especially with dark backgrounds)
- Touch targets at least 44×44 px
- Keyboard navigation support on web
- Screen reader compatibility (semantic labels)
- Visible focus indicators
- Alt text for imagery
- Proper heading hierarchy and ARIA roles

---

## 9. PERFORMANCE TARGETS

- App load time: < 2 seconds on modern devices
- Menu load: < 1 second with caching
- Checkout process: ≤ 3 main steps/screens
- API response time: < 500 ms
- Lighthouse score: 90+
- Mobile optimization score: 90+

---

## 10. DESIGN DELIVERABLES CHECKLIST

### Figma/Design Tool Artifacts
- [ ] Mob-themed component library (50+ components)
- [ ] Mobile app wireframes (35+ mob-styled screens)
- [ ] Web platform wireframes (landing + menu + flows)
- [ ] Admin panel wireframes (dark/noir theme)
- [ ] Design specifications document
- [ ] Interaction & animation guidelines
- [ ] Icon set & image assets matching mob theme
- [ ] Clickable prototypes (mobile + web)
- [ ] Brand guidelines (Mob Pizza identity)
- [ ] Typography & color usage guide

### Documentation
- [ ] User personas (customers, “The Don”/owner, staff)
- [ ] User journey maps (first-time vs returning “family members”)
- [ ] Accessibility checklist
- [ ] Performance optimization guide
- [ ] SEO guidelines (for web, mob-themed but clear)
- [ ] A/B testing ideas (mob narrative vs plain copy)

---

## 11. FUTURE ENHANCEMENTS (Post-MVP)

1. **Expanded Family Loyalty** – More ranks, exclusive “back room” menus.
2. **Advanced Analytics** – Cohort analysis, territory heatmaps.
3. **AI Recommendations** – “What the Don thinks you’ll like” based on history.
4. **Voice Ordering** – “Call the Family” via assistants.
5. **Subscription Plans** – “Monthly Tribute” pizza club.
6. **Group Ordering** – Split jobs among friends.
7. **Multi-Territory Support** – Multiple city locations with territory map.
8. **Catering Orders** – Closed-door event bookings.
9. **Marketing Automation** – Mob-themed email/SMS campaigns.
10. **Gamified Loyalty** – Unlock stories or visuals as ranks increase.

---

## 12. TESTING CHECKLIST

- [ ] Functional testing (all flows & themed labels intact)
- [ ] Cross-platform testing (iOS, Android, Web)
- [ ] Browser compatibility (Chrome, Safari, Firefox, Edge)
- [ ] Device testing (multiple screen sizes)
- [ ] Payment gateway testing (sandbox)
- [ ] Location services testing
- [ ] Notification testing (push, email, SMS)
- [ ] Performance testing (load times, transitions)
- [ ] Security testing (auth, data protection)
- [ ] Accessibility testing
- [ ] Usability testing (ensure mob theme is fun but clear)
- [ ] Edge case testing (empty states, failures)

---

## NOTES

This design plan keeps the original feature depth but re-skins Mob Pizza as a cohesive mob/speakeasy brand across mobile, web, and admin. The goal is a cinematic, story-driven experience while preserving clarity, accessibility, and performance.

**Next Steps:**
1. Approve the mob/speakeasy visual direction.
2. Update your Figma files with these colors, fonts, and component styles.
3. Create hero and section-level copy consistent with the “family” narrative.
4. Build interactive prototypes and test with users (ensure theme does not confuse core actions).
5. Prepare design handoff for Flutter, React, and backend teams.
