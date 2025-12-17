const mongoose = require('mongoose');

const menuItemSchema = new mongoose.Schema({
  name: {
    type: String,
    required: [true, 'Item name is required'],
    trim: true,
    maxlength: [100, 'Name cannot exceed 100 characters']
  },
  description: {
    type: String,
    required: [true, 'Description is required'],
    trim: true,
    maxlength: [500, 'Description cannot exceed 500 characters']
  },
  category: {
    type: String,
    required: [true, 'Category is required'],
    enum: ['boss-pies', 'family-combos', 'side-hustles', 'liquid-alibis', 'under-the-table-deals'],
    lowercase: true
  },
  image: {
    type: String,
    default: null
  },
  basePrice: {
    type: Number,
    required: [true, 'Base price is required'],
    min: [0, 'Price cannot be negative']
  },
  sizes: [{
    name: {
      type: String,
      required: true,
      enum: ['small', 'medium', 'large', 'extra-large']
    },
    price: {
      type: Number,
      required: true,
      min: [0, 'Price cannot be negative']
    },
    calories: {
      type: Number,
      min: 0
    }
  }],
  toppings: [{
    id: {
      type: String,
      required: true
    },
    name: {
      type: String,
      required: true,
      trim: true
    },
    price: {
      type: Number,
      required: true,
      min: [0, 'Price cannot be negative']
    },
    category: {
      type: String,
      enum: ['vegetable', 'meat', 'cheese', 'sauce'],
      default: 'vegetable'
    }
  }],
  isVegetarian: {
    type: Boolean,
    default: false
  },
  isAvailable: {
    type: Boolean,
    default: true
  },
  preparationTime: {
    type: Number,
    min: 5,
    max: 60,
    default: 15
  },
  rating: {
    type: Number,
    min: 0,
    max: 5,
    default: 0
  },
  allergens: [{
    type: String,
    trim: true,
    lowercase: true
  }],
  tags: [{
    type: String,
    trim: true,
    lowercase: true
  }]
}, {
  timestamps: true,
  toJSON: { virtuals: true },
  toObject: { virtuals: true }
});

// Indexes for better query performance
menuItemSchema.index({ category: 1, isAvailable: 1 });
menuItemSchema.index({ name: 'text', description: 'text' });
menuItemSchema.index({ rating: -1 });
menuItemSchema.index({ basePrice: 1 });
menuItemSchema.index({ createdAt: -1 });

// Virtual for review count
menuItemSchema.virtual('reviews', {
  ref: 'Review',
  localField: '_id',
  foreignField: 'item',
  count: true
});

// Static method to get featured items
menuItemSchema.statics.getFeatured = function(limit = 10) {
  return this.find({ isAvailable: true })
    .sort({ rating: -1, createdAt: -1 })
    .limit(limit);
};

// Static method to get items by category
menuItemSchema.statics.getByCategory = function(category, limit = 20) {
  return this.find({ category, isAvailable: true })
    .sort({ rating: -1 })
    .limit(limit);
};

module.exports = mongoose.model('MenuItem', menuItemSchema);
