const mongoose = require("mongoose");

const restaurantSchema = new mongoose.Schema({
  title: { type: String, require: true },
  value: { type: String, require: true },
  time: { type: String, require: true },
  imageUrl: { type: String, require: true },
  foods: { type: Array, default: [] },
  pickup: { type: Boolean, default: true },
  delivery: { type: Boolean, default: true },
  isAvailable: { type: Boolean, default: true },
  owner: { type: String, require: true },
  code: { type: String, require: true },
  logoUrl: { type: String, require: true },
  rating: { type: Number, min: 1, max: 5, default: 3.5 },
  ratingCount: { type: String, default: 267 },
  verification: {
    type: String,
    default: "Pending",
    enum: ["Pending", "Verified", "Reject"],
  },
  verificationMessage: {
    type: String,
    default:
      "Your restaurant is under review. We will notify you once it is verified.",
  },
  coords: {
    id: { type: String },
    latitude: { type: Number, required: true },
    longitude: { type: Number, required: true },
    // latitudeDelta: { type: Number, default: 0.0122 },
    // longitudeDelta: { type: Number, default: 0.0122 },
    address: { type: String, required: true },
    title: { type: String, required: true },
  },
  earnings: { type: Number, default: 0.4765 },
});

module.exports = mongoose.model("Restaurant", restaurantSchema);
