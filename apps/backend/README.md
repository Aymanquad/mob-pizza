# Mob Pizza Backend API

Node.js/Express backend for the Mob Pizza food ordering system with MongoDB storage.

## 🚀 Quick Start

### Prerequisites
- Node.js 18+
- MongoDB (local or MongoDB Atlas)
- npm or yarn

### Installation

1. **Clone and install dependencies:**
   ```bash
   cd apps/backend
   npm install
   ```

2. **Environment Setup:**
   ```bash
   cp env.example .env
   # Edit .env with your MongoDB connection string
   ```

3. **Start MongoDB:**
   - **Local MongoDB:** Install and start MongoDB on your system
   - **MongoDB Atlas:** Get connection string from Atlas dashboard

4. **Seed the database:**
   ```bash
   npm run seed
   ```

5. **Start the development server:**
   ```bash
   npm run dev
   ```

The API will be available at `http://localhost:5000`

## 📁 Project Structure

```
src/
├── config/
│   └── database.js          # MongoDB connection
├── models/                  # Mongoose schemas
│   ├── User.js
│   ├── MenuItem.js
│   ├── Order.js
│   ├── Address.js
│   ├── Review.js
│   ├── Promo.js
│   └── DeliveryPartner.js
├── controllers/             # Route handlers
├── routes/                  # API routes
├── middleware/              # Custom middleware
├── services/                # Business logic
├── utils/                   # Helper functions
├── seeders/                 # Database seeders
│   ├── index.js
│   ├── seedUsers.js
│   └── seedMenu.js
└── index.js                 # App entry point
```

## 🗄️ Database Collections

The API uses MongoDB with the following collections:

- **Users**: Customer, admin, and delivery partner accounts
- **MenuItems**: Pizza items, sides, drinks with pricing and customization
- **Orders**: Customer orders with status tracking
- **Addresses**: Delivery addresses for users
- **Reviews**: Customer reviews and ratings
- **Promos**: Discount codes and promotional offers
- **DeliveryPartners**: Delivery personnel information

## 🔧 Environment Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `PORT` | Server port | `5000` |
| `NODE_ENV` | Environment | `development` |
| `MONGO_URI` | MongoDB connection string | Required |
| `JWT_SECRET` | JWT signing secret | Required |
| `JWT_EXPIRES_IN` | JWT expiration time | `7d` |

## 🌱 Seeding Data

Run the seeder to populate your database with sample data:

```bash
npm run seed
```

This creates:
- Sample users (customer, admin, delivery)
- Menu items (pizzas, sides, drinks)
- Basic configuration data

## 🔌 API Endpoints

The API provides RESTful endpoints for:

- **Authentication**: Register, login, logout, refresh tokens
- **Menu**: Browse items, search, categories, featured items
- **Orders**: Create, track, manage orders
- **Users**: Profile management, addresses, favorites
- **Reviews**: Submit and view reviews
- **Promos**: Validate discount codes
- **Admin**: Dashboard, order management, menu management

## 🧪 Testing

Test the API using the provided Postman collection or curl commands in the API specification.

## 📦 Deployment

### Development
```bash
npm run dev
```

### Production
```bash
npm run start
```

### Docker (Optional)
```bash
docker build -t mob-pizza-backend .
docker run -p 5000:5000 mob-pizza-backend
```

## 🔒 Security Features

- JWT authentication with refresh tokens
- Password hashing with bcrypt
- Rate limiting
- CORS protection
- Input validation with Joi
- XSS protection
- Secure headers (Helmet.js)

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Run tests
5. Submit a pull request

## 📄 License

This project is part of the Mob Pizza application suite.
