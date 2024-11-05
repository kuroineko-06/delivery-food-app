const Rating = require("../models/rating");
const Restaurant = require("../models/restaurant");
const Food = require("../models/food");

module.exports = {
  addRating: async (req, res) => {
    const newRating = new Rating({
      userId: req.user.id,
      ratingType: req.body.rating,
      product: req.body.product,
      rating: req.body.rating,
    });

    try {
      await newRating.save();
      if (req.body.ratingType === "Restaurant") {
        const restaurant = await Rating.aggregate([
          {
            $match: {
              ratingType: req.body.ratingType,
              product: req.body.product,
            },
          },
          { $group: { _id: "$product" }, averateRating: { $avg: "$rating" } },
        ]);

        if (restaurant.length > 0) {
          const averateRating = restaurant[0].averateRating;
          await Restaurant.findByIdAndUpdate(
            req.body.product,
            { rating: averateRating },
            { new: true }
          );
        }
      } else if (req.body.ratingType === "Food") {
        const foods = await Rating.aggregate([
          {
            $match: {
              ratingType: req.body.ratingType,
              product: req.body.product,
            },
          },
          { $group: { _id: "$product" }, averateRating: { $avg: "$rating" } },
        ]);

        if (foods.length > 0) {
          const averateRating = foods[0].averateRating;
          await Food.findByIdAndUpdate(
            req.body.product,
            { rating: averateRating },
            { new: true }
          );
        }
      }

      res
        .status(200)
        .json({ status: true, message: "Rating updated successfully!" });
    } catch (error) {
      res.status(500).json({ status: false, message: error.message });
    }
  },

  checkUserRating: async (req, res) => {
    const ratingType = req.query.ratingType;
    const product = req.query.product;

    try {
      const existingRating = await Rating.findOne({
        userId: req.user.id,
        product: product,
        ratingType: ratingType,
      });

      if (existingRating) {
        res.status(200).json({
          status: true,
          message: "You have already rate this restaurant",
        });
      } else {
        res.status(400).json({
          status: false,
          message: "User hasn't rated this restaurant",
        });
      }
    } catch (error) {
      res.status(500).json({ status: false, message: error.message });
    }
  },
};
