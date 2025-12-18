const mongoose = require('mongoose');
const bcrypt = require('bcryptjs');

// Embedded address schema (user-scoped)
const addressSchema = new mongoose.Schema(
  {
    label: {
      type: String,
      required: [true, 'Address label is required'],
      enum: ['home', 'office', 'other'],
      default: 'home',
    },
    street: {
      type: String,
      required: [true, 'Street address is required'],
      trim: true,
      maxlength: [200, 'Street address cannot exceed 200 characters'],
    },
    city: {
      type: String,
      required: false, // Made optional for simple address entry
      trim: true,
      maxlength: [50, 'City cannot exceed 50 characters'],
      default: '',
    },
    state: {
      type: String,
      required: false, // Made optional for simple address entry
      trim: true,
      maxlength: [50, 'State cannot exceed 50 characters'],
      default: '',
    },
    zipCode: {
      type: String,
      required: false, // Made optional for simple address entry
      trim: true,
      maxlength: [10, 'ZIP code cannot exceed 10 characters'],
      default: '',
    },
    coordinates: {
      type: {
        type: String,
        enum: ['Point'],
        default: 'Point',
      },
      coordinates: {
        type: [Number], // [longitude, latitude]
        required: false, // Make coordinates optional
        validate: {
          validator: function (coords) {
            // If coordinates are provided, validate them
            if (!coords || coords.length === 0) return true; // Allow empty/undefined
            return (
              coords.length === 2 &&
              coords[0] >= -180 &&
              coords[0] <= 180 &&
              coords[1] >= -90 &&
              coords[1] <= 90
            );
          },
          message: 'Invalid coordinates format',
        },
      },
    },
    instructions: {
      type: String,
      trim: true,
      maxlength: [200, 'Delivery instructions cannot exceed 200 characters'],
    },
    isDefault: {
      type: Boolean,
      default: false,
    },
  },
  { _id: true }
);

// Embedded payment method schema (user-scoped)
const paymentMethodSchema = new mongoose.Schema(
  {
    brand: {
      type: String,
      trim: true,
    },
    last4: {
      type: String,
      trim: true,
      minlength: 4,
      maxlength: 4,
    },
    expiryMonth: Number,
    expiryYear: Number,
    token: {
      type: String,
      trim: true,
    },
    isDefault: {
      type: Boolean,
      default: false,
    },
  },
  { _id: true }
);

const userSchema = new mongoose.Schema(
  {
    firstName: {
      type: String,
      required: [true, 'First name is required'],
      trim: true,
      maxlength: [50, 'First name cannot exceed 50 characters'],
    },
    lastName: {
      type: String,
      required: [true, 'Last name is required'],
      trim: true,
      maxlength: [50, 'Last name cannot exceed 50 characters'],
    },
    email: {
      type: String,
      required: false, // Optional for now - no email input in app yet
      unique: true,
      sparse: true, // Allow multiple null emails
      lowercase: true,
      trim: true,
      match: [/^[^\s@]+@[^\s@]+\.[^\s@]+$/, 'Please enter a valid email'],
      default: null,
    },
    phone: {
      type: String,
      required: [true, 'Phone number is required'],
      unique: true,
      trim: true,
      match: [/^\+?[1-9]\d{1,14}$/, 'Please enter a valid phone number'],
    },
    passwordHash: {
      type: String,
      required: [true, 'Password is required'],
      minlength: [6, 'Password must be at least 6 characters long'],
    },
    profileImage: {
      type: String,
      default: null,
    },
    role: {
      type: String,
      enum: ['customer', 'admin', 'delivery'],
      default: 'customer',
    },
    preferences: {
      dietary: [
        {
          type: String,
          enum: ['vegetarian', 'vegan', 'gluten-free', 'halal', 'kosher'],
        },
      ],
      spiceLevel: {
        type: String,
        enum: ['mild', 'medium', 'hot', 'extra-hot'],
        default: 'medium',
      },
      allergies: [
        {
          type: String,
          trim: true,
        },
      ],
    },
    loyaltyPoints: {
      type: Number,
      default: 0,
      min: 0,
    },
    isActive: {
      type: Boolean,
      default: true,
    },
    emailVerified: {
      type: Boolean,
      default: false,
    },
    phoneVerified: {
      type: Boolean,
      default: false,
    },
    locale: {
      type: String,
      enum: ['en', 'es'],
      default: 'en',
    },
    consents: {
      location: {
        type: Boolean,
        default: false,
      },
      notifications: {
        type: Boolean,
        default: false,
      },
    },
    onboardingCompleted: {
      type: Boolean,
      default: false,
    },
    onboardingAt: {
      type: Date,
      default: null,
    },
    // User-scoped nested data
    addresses: {
      type: [addressSchema],
      default: [],
    },
    favorites: [
      {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'MenuItem',
      },
    ],
    paymentMethods: {
      type: [paymentMethodSchema],
      default: [],
    },
    ordersCount: {
      type: Number,
      default: 0,
      min: 0,
    },
    lastOrderAt: {
      type: Date,
      default: null,
    },
    // Cart items (embedded array)
    cart: {
      type: [
        {
          id: {
            type: String,
            required: true,
          },
          name: {
            type: String,
            required: true,
          },
          description: String,
          basePrice: {
            type: Number,
            required: true,
            min: 0,
          },
          isVegetarian: {
            type: Boolean,
            default: false,
          },
          imagePath: String,
          selectedSize: {
            type: String,
            required: true,
            enum: ['Solo', 'Crew', 'Family'],
          },
          selectedToppings: [String],
          quantity: {
            type: Number,
            required: true,
            min: 1,
            default: 1,
          },
        },
      ],
      default: [],
    },
  },
  {
    timestamps: true,
    toJSON: { virtuals: true },
    toObject: { virtuals: true },
  }
);

// Virtual for full name
userSchema.virtual('fullName').get(function () {
  return `${this.firstName} ${this.lastName}`;
});

// Virtual to get default address
userSchema.virtual('defaultAddress').get(function () {
  if (!this.addresses) return null;
  return this.addresses.find((addr) => addr.isDefault) || this.addresses[0] || null;
});

// Index for better query performance
userSchema.index({ email: 1 });
userSchema.index({ phone: 1 });
userSchema.index({ role: 1 });
userSchema.index({ createdAt: -1 });
userSchema.index({ 'addresses.isDefault': 1 });
userSchema.index({ favorites: 1 });

// Hash password before saving
userSchema.pre('save', async function (next) {
  if (!this.isModified('passwordHash')) return next();

  try {
    const salt = await bcrypt.genSalt(12);
    this.passwordHash = await bcrypt.hash(this.passwordHash, salt);
    next();
  } catch (error) {
    next(error);
  }
});

// Ensure only one default address
userSchema.pre('save', function (next) {
  if (!this.isModified('addresses')) return next();
  const defaults = this.addresses?.filter((addr) => addr.isDefault) || [];
  if (defaults.length > 1) {
    // Keep the first default, unset others
    const keepId = defaults[0]._id?.toString?.();
    this.addresses = this.addresses.map((addr) =>
      addr.isDefault && keepId && addr._id?.toString?.() !== keepId
        ? { ...addr.toObject(), isDefault: false }
        : addr
    );
  }
  next();
});

// Compare password method
userSchema.methods.comparePassword = async function (candidatePassword) {
  return bcrypt.compare(candidatePassword, this.passwordHash);
};

// Remove password from JSON output
userSchema.methods.toJSON = function () {
  const userObject = this.toObject();
  delete userObject.passwordHash;
  delete userObject.__v;
  return userObject;
};

module.exports = mongoose.model('User', userSchema);
