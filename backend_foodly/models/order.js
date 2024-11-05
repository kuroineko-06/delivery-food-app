const mongoose = require("mongoose");

const orderItemSchema = new mongoose.Schema({
  foodId: { type: mongoose.Schema.Types.ObjectId, ref: "Food" },
  quantity: { type: Number, default: 1 },
  price: { type: Number, require: true },
  additives: { type: Array },
  instructions: { type: String, default: "" },
});

const orderSchema = new mongoose.Schema(
  {
    userId: { type: mongoose.Schema.Types.ObjectId, ref: "User" },
    orderItems: [orderItemSchema],
    orderTotal: { type: Number, require: true },
    deliveryFee: { type: Number, require: true },
    grandTotal: { type: Number, require: true },
    deliveryAddress: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Address",
      require: true,
    },
    restaurantAddress: { type: String, require: true },
    paymentMethod: { type: String, require: true },
    paymentStatus: {
      type: String,
      default: "Pending",
      enum: ["Pending", "Complete", "Failed"],
    },
    orderStatus: {
      type: String,
      default: "Pending",
      enum: [
        "Pending",
        "Placed",
        "Accepted",
        "Preparing",
        "Manual",
        "Delivered",
        "Cancelled",
        "Ready",
        "Out_for_Delivery",
      ],
    },
    restaurantId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Restaurant",
    },
    restaurantCoords: [Number],
    recipientCoords: [Number],
    driverId: {
      type: String,
      default: "66f5a4e6421f6b5fd374d397",
    },
    rating: { type: Number, min: 1, max: 5, default: 3 },
    feedback: { type: String },
    promoCode: { type: String },
    discountAmount: { type: Number },
    note: { type: String },
  },
  { timestamps: true }
);

module.exports = mongoose.model("Order", orderSchema);
