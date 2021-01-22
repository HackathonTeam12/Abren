const express = require("express");
const router = express.Router();
module.exports = function iniRouter(app) {
	app.use(router.get("/", (req, res) => {
		res.send('Hello')
	}));
};