const mongoose = require("mongoose");
require("dotenv").config();

let connectionString = process.env.DB_CONNECTION;

mongoose.connect(
  connectionString,
  {
    useCreateIndex: true,
    useNewUrlParser: true,
    useUnifiedTopology: true,
    useFindAndModify: false,
  },
  function (err, res) {
    if (err) {
      console.log("Error connecting to database. " + err);
    } else {
      console.log(
        "Connected to Database! " +
          connectionString
      );
    }
  }
);
