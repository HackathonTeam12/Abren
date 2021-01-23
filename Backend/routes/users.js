const express = require('express');
const UsersController = require('../controllers/users');
const auth = require('../middlewares/auth');
var multer  = require('multer')
var upload = multer({ dest: 'uploads/' })

const router = express.Router();

router.post("/api/auth/signup", upload.fields([{name: "profile", maxCount: 1}, {name: "id_card", maxCount: 1}]), UsersController.signup);
router.post("/api/auth/login", UsersController.login);
router.get("/api/users/profile", auth.verify_token, UsersController.get_profile);
// router.get("/api/users/profile", UsersController.get_profile);
router.patch("/api/users/profile", upload.fields([{name: "profile", maxCount: 1}, {name: "id_card", maxCount: 1}]), auth.verify_token, UsersController.update_profile);
router.post("/api/users/upgrade_account", auth.verify_token, auth.grant_access("updateOwn", "account"), UsersController.upgrade_account);
router.post("/api/users/rate", auth.verify_token, UsersController.rate);
router.get("/api/users/history", auth.verify_token, UsersController.history);

module.exports = router;