const router = require("express").Router();
const paymentController = require("../controllers/payment_method");

router.get("/createpayment", paymentController.createPaymentMethod);
router.get("/execute", paymentController.Execute);

module.exports = router;
