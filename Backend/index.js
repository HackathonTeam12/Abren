const express = require("express");
const db = require("./db");
const bodyParser = require("body-parser");
const router = require("./routes");
const cors = require("cors");

const port = 3000;
const app = express();
app.use(cors());
app.listen(port, () => {
  console.log(`App listening at http://localhost:${port}`)
})

require("dotenv").config();

app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

router(app);

module.exports = app;
