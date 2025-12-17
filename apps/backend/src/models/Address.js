const mongoose = require('mongoose');

const addressSchema = new mongoose.Schema({
  user: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User',
    required: [true, 'User is required']
  },
  label: {
    type: String,
    required: [true, 'Address label is required'],
    enum: ['home', 'office', 'other'],
    default: 'home'
  },
  street: {
    type: String,
    required: [true, 'Street address is required'],
    trim: true,
    maxlength: [200, 'Street address cannot exceed 200 characters']
  },
  city: {
    type: String,
    required: [true, 'City is required'],
    trim: true,
    maxlength: [50, 'City cannot exceed 50 characters']
  },
  state: {
    type: String,
    required: [true, 'State is required'],
    trim: true,
    maxlength: [50, 'State cannot exceed 50 characters']
  },
  zipCode: {
    type: String,
    required: [true, 'ZIP code is required'],
    trim: true,
    maxlength: [10, 'ZIP code cannot exceed 10 characters']
  },
  coordinates: {
    type: {
      type: String,
      enum: ['Point'],
      default: 'Point'
    },
    coordinates: {
      type: [Number], // [longitude, latitude]
      required: true,
      validate: {
        validator: function(coords) {
          return coords.length === 2 &&
                 coords[0] >= -180 && coords[0] <= 180 && // longitude
                 coords[1] >= -90 && coords[1] <= 90;    // latitude
        },
        message: 'Invalid coordinates format'
      }
    }
  },
  instructions: {
    type: String,
    trim: true,
    maxlength: [200, 'Delivery instructions cannot exceed 200 characters']
  },
  isDefault: {
    type: Boolean,
    default: false
  }
}, {
  timestamps: true,
  toJSON: { virtuals: true },
  toObject: { virtuals: true }
});

// Indexes for better query performance
addressSchema.index({ user: 1 });
addressSchema.index({ coordinates: '2dsphere' });
addressSchema.index({ user: 1, isDefault: 1 });

// Virtual for full address string
addressSchema.virtual('fullAddress').get(function() {
  return `${this.street}, ${this.city}, ${this.state} ${this.zipCode}`;
});

// Pre-save middleware to ensure only one default address per user
addressSchema.pre('save', async function(next) {
  if (this.isDefault) {
    await mongoose.model('Address').updateMany(
      { user: this.user, _id: { $ne: this._id } },
      { isDefault: false }
    );
  }
  next();
});

// Static method to get user's default address
addressSchema.statics.getDefaultAddress = function(userId) {
  return this.findOne({ user: userId, isDefault: true });
};

// Static method to get all user addresses
addressSchema.statics.getUserAddresses = function(userId) {
  return this.find({ user: userId }).sort({ isDefault: -1, createdAt: -1 });
};

module.exports = mongoose.model('Address', addressSchema);
