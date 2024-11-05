const router = require("express").Router();
const restaurantController = require("../controllers/restaurant_controller");
const { verifyTokenAndAuthorization } = require("../middleware/verifyToken");

router.post(
  "/",
  verifyTokenAndAuthorization,
  restaurantController.addRestaurant
);
router.get("/byId/:id", restaurantController.getRestaurantById);
router.get("/all", restaurantController.getAllNearByRestaurant);
router.get("/:code", restaurantController.getRandomRestaurant);
router.get(
  "/owner/profile",
  verifyTokenAndAuthorization,
  restaurantController.getRestaurantByProfile
);

module.exports = router;
