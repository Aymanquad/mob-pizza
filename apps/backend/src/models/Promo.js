const mongoose = require('mongoose');

const promoSchema = new mongoose.Schema({
  code: {
    type: String,
    required: [true, 'Promo code is required'],
    unique: true,
    uppercase: true,
    trim: true,
    minlength: [3, 'Code must be at least 3 characters'],
    maxlength: [20, 'Code cannot exceed 20 characters']
  },
  discountType: {
    type: String,
    required: [true, 'Discount type is required'],
    enum: ['percentage', 'fixed'],
    default: 'percentage'
  },
  discountValue: {
    type: Number,
    required: [true, 'Discount value is required'],
    min: [0, 'Discount value cannot be negative'],
    validate: {
      validator: function(value) {
        if (this.discountType === 'percentage') {
          return value <= 100;
        }
        return value <= 10000; // Max $100 fixed discount
      },
      message: 'Invalid discount value'
    }
  },
  minOrderValue: {
    type: Number,
    default: 0,
    min: [0, 'Minimum order value cannot be negative']
  },
  maxDiscount: {
    type: Number,
    min: 0
  },
  usageLimit: {
    type: Number,
    min: 1,
    max: 10000
  },
  usageCount: {
    type: Number,
    default: 0,
    min: 0
  },
  validFrom: {
    type: Date,
    required: [true, 'Valid from date is required'],
    default: Date.now
  },
  validTo: {
    type: Date,
    required: [true, 'Valid to date is required'],
    validate: {
      validator: function(value) {
        return value > this.validFrom;
      },
      message: 'Valid to date must be after valid from date'
    }
  },
  applicableOn: [{
    type: String,
    enum: ['all', 'boss-pies', 'family-combos', 'side-hustles', 'liquid-alibis'],
    default: ['all']
  }],
  isActive: {
    type: Boolean,
    default: true
  },
  description: {
    type: String,
    trim: true,
    maxlength: [200, 'Description cannot exceed 200 characters']
  },
  createdBy: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User'
  }
}, {
  timestamps: true,
  toJSON: { virtuals: true },
  toObject: { virtuals: true }
});

// Indexes for better query performance
promoSchema.index({ code: 1 });
promoSchema.index({ isActive: 1, validTo: 1 });
promoSchema.index({ createdAt: -1 });

// Virtual for remaining uses
promoSchema.virtual('remainingUses').get(function() {
  if (!this.usageLimit) return Infinity;
  return Math.max(0, this.usageLimit - this.usageCount);
});

// Virtual for isExpired
promoSchema.virtual('isExpired').get(function() {
  return new Date() > this.validTo;
});

// Virtual for isValid
promoSchema.virtual('isValid').get(function() {
  return this.isActive && !this.isExpired && this.remainingUses > 0;
});

// Static method to find valid promo by code
promoSchema.statics.findValidPromo = function(code, orderValue = 0) {
  return this.findOne({
    code: code.toUpperCase(),
    isActive: true,
    validFrom: { $lte: new Date() },
    validTo: { $gte: new Date() },
    $or: [
      { usageLimit: { $exists: false } },
      { $expr: { $lt: ['$usageCount', '$usageLimit'] } }
    ],
    $or: [
      { minOrderValue: 0 },
      { minOrderValue: { $lte: orderValue } }
    ]
  });
};

// Static method to get active promos
promoSchema.statics.getActivePromos = function(limit = 20) {
  return this.find({
    isActive: true,
    validFrom: { $lte: new Date() },
    validTo: { $gte: new Date() }
  })
  .sort({ createdAt: -1 })
  .limit(limit);
};

// Pre-save middleware to validate usage count
promoSchema.pre('save', function(next) {
  if (this.usageLimit && this.usageCount > this.usageLimit) {
    next(new Error('Usage count cannot exceed usage limit'));
  }
  next();
});

module.exports = mongoose.model('Promo', promoSchema);
