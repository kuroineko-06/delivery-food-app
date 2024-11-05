const router = require("express").Router();
const categoriesController = require("../controllers/category_controller");

router.post("/", categoriesController.createCategory);
router.get("/", categoriesController.getAllCategory);
router.get("/random", categoriesController.getRandomCategories);

module.exports = router;
