const router = require("express").Router();
const authController = require("../controllers/auth_controller");

router.post("/register", authController.createUser);
router.post("/login", authController.loginUser);

module.exports = router;
