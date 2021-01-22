const express = require("express");
const RoutesController = require("../controllers/routes");
const auth = require("../middlewares/auth");
const router = express.Router();

router.get("/api/routes", auth.verify_token, RoutesController.get); //TODO: only admin
router.get("/api/routes/user", auth.verify_token, RoutesController.get_user);
router.post("/api/routes", auth.verify_token, RoutesController.create);
router.patch("/api/routes", auth.verify_token, RoutesController.update);

module.exports = router;
