const mongoose = require('mongoose');

const reviewSchema = new mongoose.Schema({
  item: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'MenuItem',
    required: [true, 'Menu item is required']
  },
  user: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User',
    required: [true, 'User is required']
  },
  order: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Order',
    required: [true, 'Order is required']
  },
  rating: {
    type: Number,
    required: [true, 'Rating is required'],
    min: [1, 'Rating must be at least 1'],
    max: [5, 'Rating cannot exceed 5']
  },
  comment: {
    type: String,
    required: [true, 'Comment is required'],
    trim: true,
    maxlength: [500, 'Comment cannot exceed 500 characters']
  },
  images: [{
    type: String,
    trim: true
  }],
  isVerifiedPurchase: {
    type: Boolean,
    default: true
  },
  helpful: {
    type: Number,
    default: 0,
    min: 0
  },
  reported: {
    type: Boolean,
    default: false
  }
}, {
  timestamps: true,
  toJSON: { virtuals: true },
  toObject: { virtuals: true }
});

// Indexes for better query performance
reviewSchema.index({ item: 1, createdAt: -1 });
reviewSchema.index({ user: 1, createdAt: -1 });
reviewSchema.index({ rating: -1 });
reviewSchema.index({ createdAt: -1 });

// Compound index to prevent duplicate reviews
reviewSchema.index({ item: 1, user: 1, order: 1 }, { unique: true });

// Static method to get item reviews with pagination
reviewSchema.statics.getItemReviews = function(itemId, page = 1, limit = 10) {
  const skip = (page - 1) * limit;
  return this.find({ item: itemId })
    .populate('user', 'firstName lastName profileImage')
    .sort({ createdAt: -1 })
    .skip(skip)
    .limit(limit);
};

// Static method to get average rating for an item
reviewSchema.statics.getAverageRating = function(itemId) {
  return this.aggregate([
    { $match: { item: mongoose.Types.ObjectId(itemId) } },
    {
      $group: {
        _id: '$item',
        averageRating: { $avg: '$rating' },
        totalReviews: { $sum: 1 }
      }
    }
  ]);
};

// Static method to get user's reviews
reviewSchema.statics.getUserReviews = function(userId, limit = 20) {
  return this.find({ user: userId })
    .populate('item', 'name image category')
    .populate('order', 'orderId')
    .sort({ createdAt: -1 })
    .limit(limit);
};

module.exports = mongoose.model('Review', reviewSchema);
