const router = require("express").Router();
const addressController = require("../controllers/address_controller");
const { verifyTokenAndAuthorization } = require("../middleware/verifyToken");

router.post("/", verifyTokenAndAuthorization, addressController.addAddress);
router.get(
  "/default",
  verifyTokenAndAuthorization,
  addressController.getDefaultAddress
);
router.delete(
  "/:id",
  verifyTokenAndAuthorization,
  addressController.deleteAddress
);

router.put(
  "/:id",
  verifyTokenAndAuthorization,
  addressController.updateAddress
);

router.patch(
  "/default/:id",
  verifyTokenAndAuthorization,
  addressController.setAddressDefault
);
router.get("/all", verifyTokenAndAuthorization, addressController.getAddress);

module.exports = router;
