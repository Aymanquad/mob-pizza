const mongoose = require('mongoose');

const deliveryPartnerSchema = new mongoose.Schema({
  user: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User',
    required: [true, 'User reference is required']
  },
  vehicle: {
    type: {
      type: String,
      enum: ['bike', 'scooter', 'car', 'van'],
      required: [true, 'Vehicle type is required']
    },
    number: {
      type: String,
      required: [true, 'Vehicle number is required'],
      uppercase: true,
      trim: true
    }
  },
  licenseNumber: {
    type: String,
    required: [true, 'License number is required'],
    uppercase: true,
    trim: true
  },
  currentLocation: {
    type: {
      type: String,
      enum: ['Point'],
      default: 'Point'
    },
    coordinates: {
      type: [Number], // [longitude, latitude]
      required: true
    }
  },
  isAvailable: {
    type: Boolean,
    default: true
  },
  isActive: {
    type: Boolean,
    default: true
  },
  totalDeliveries: {
    type: Number,
    default: 0,
    min: 0
  },
  rating: {
    type: Number,
    min: 0,
    max: 5,
    default: 0
  },
  documents: {
    license: String, // URL to license document
    vehicleRegistration: String, // URL to vehicle registration
    insurance: String // URL to insurance document
  }
}, {
  timestamps: true,
  toJSON: { virtuals: true },
  toObject: { virtuals: true }
});

// Indexes for better query performance
deliveryPartnerSchema.index({ user: 1 }, { unique: true });
deliveryPartnerSchema.index({ currentLocation: '2dsphere' });
deliveryPartnerSchema.index({ isAvailable: 1, isActive: 1 });
deliveryPartnerSchema.index({ rating: -1 });

// Virtual for full name (inherited from User)
deliveryPartnerSchema.virtual('fullName', {
  ref: 'User',
  localField: 'user',
  foreignField: '_id',
  justOne: true,
  options: { select: 'firstName lastName' }
});

// Static method to find nearest available partners
deliveryPartnerSchema.statics.findNearestAvailable = function(longitude, latitude, maxDistance = 5000) {
  return this.find({
    isAvailable: true,
    isActive: true,
    currentLocation: {
      $near: {
        $geometry: {
          type: 'Point',
          coordinates: [longitude, latitude]
        },
        $maxDistance: maxDistance // 5km radius
      }
    }
  })
  .populate('user', 'firstName lastName phone')
  .limit(10);
};

// Static method to get active partners
deliveryPartnerSchema.statics.getActivePartners = function(limit = 50) {
  return this.find({ isActive: true })
    .populate('user', 'firstName lastName phone rating')
    .sort({ rating: -1, totalDeliveries: -1 })
    .limit(limit);
};

module.exports = mongoose.model('DeliveryPartner', deliveryPartnerSchema);
