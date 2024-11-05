const Restaurant = require("../models/restaurant");
const User = require("../models/user");

module.exports = {
  addRestaurant: async (req, res) => {
    const owner = req.user.id;
    const { title, time, imageUrl, code, logoUrl, coords } = req.body;

    if (
      !title ||
      !time ||
      !imageUrl ||
      !code ||
      !owner ||
      !logoUrl ||
      !coords ||
      !coords.latitude ||
      !coords.longitude ||
      !coords.address ||
      !coords.title
    ) {
      return res
        .status(400)
        .json({ status: false, message: "You have a missing field" });
    }

    try {
      const newRestaurant = new Restaurant(req.body);
      await newRestaurant.save();
      const user = await User.findByIdAndUpdate(
        owner,
        { userType: "Vendor" },
        { new: true }
      );

      await user.save();
      res.status(201).json({
        status: true,
        message: "Restaurant has been added successfully!",
      });
    } catch (error) {
      res.status(500).json({ status: false, message: error.message });
    }
  },

  getRestaurantById: async (req, res) => {
    const id = req.params.id;
    try {
      const restaurant = await Restaurant.findById(id);
      res.status(200).json(restaurant);
    } catch (error) {
      res.status(500).json({ status: false, message: error.message });
    }
  },

  getAllNearByRestaurant: async (req, res) => {
    try {
      let randomRestaurant = [];

      randomRestaurant = await Restaurant.aggregate([
        { $match: { isAvailable: true } },
        { $sample: { size: 5 } },
        { $project: { __v: 0 } },
      ]);

      if (randomRestaurant.length === 0) {
        randomRestaurant = await Restaurant.aggregate([
          { $match: { isAvailable: true } },
          { $sample: { size: 5 } },
          { $project: { __v: 0 } },
        ]);
      }
      res.status(200).json(randomRestaurant);
    } catch (error) {
      res.status(500).json({ status: false, message: error.message });
    }
  },

  getRandomRestaurant: async (req, res) => {
    const code = req.params.code;

    try {
      let allNearByRestaurant = [];

      if (code) {
        allNearByRestaurant = await Restaurant.aggregate([
          { $match: { code: code, isAvailable: true } },
          { $project: { __v: 0 } },
        ]);
      }

      if (allNearByRestaurant.length === 0) {
        allNearByRestaurant = await Restaurant.aggregate([
          { $match: { isAvailable: true } },
          { $project: { __v: 0 } },
        ]);
      }
      res.status(200).json(allNearByRestaurant);
    } catch (error) {
      res.status(500).json({ status: false, message: error.message });
    }
  },

  getRestaurantByProfile: async (req, res) => {
    const owner = req.user.id;
    try {
      const restaurant = await Restaurant.findOne({ owner: owner });
      if (!restaurant) {
        return res
          .status(404)
          .json({ status: false, message: "Restaurant not found" });
      }
      res.status(200).json(restaurant);
    } catch (error) {
      res.status(500).json({ status: false, message: error.message });
    }
  },
};
