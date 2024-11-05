const mongoose = require("mongoose");

const cartSchema = new mongoose.Schema(
  {
    userId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
      require: true,
    },
    productId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Food",
      require: true,
    },
    additives: { type: Array, require: false, default: [] },
    totalPrice: { type: Number, require: true },
    quantity: { type: Number, require: true },
  },
  { timestamps: true }
);

module.exports = mongoose.model("Cart", cartSchema);
