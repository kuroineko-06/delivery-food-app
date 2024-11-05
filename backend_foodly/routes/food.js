const router = require("express").Router();
const foodController = require("../controllers/food_controller");
const { verifyVendor } = require("../middleware/verifyToken");

router.post("/", verifyVendor, foodController.addFood);

router.get("/:id", foodController.getFoodById);
router.get("/byCode/:code", foodController.getAllFoodByCode);
router.get("/search/:search", foodController.searchFoods);
router.get("/recommendation/:code", foodController.getRandomFood);

router.put("/:id", foodController.updateFoods);

router.get("/restaurant-foods/:id", foodController.getFoodByRestaurant);

router.get("/:category/:code", foodController.getFoodByCategoryAndCode);

module.exports = router;
