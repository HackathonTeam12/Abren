const mongoose = require("mongoose");
require('dotenv').config();

const ride_schema = new mongoose.Schema({ //TODO: Revisit, put requests in here?
    driver_id: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "User"
    },
    route_id: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Route"
    },
    driver_location: {
      latitude : {
        type: Number,
        // required: true,
      },
      longitude : {
        type: Number,
        // required: true,
      }
  },  
  status: {
    type: String,
    enum: ["ACTIVE", "HISTORY", "CANCELED"],
    default: "ACTIVE"
  }
}, {timestamps: {createdAt: "created_at", updatedAt: "updated_at"}}); //TODO: Deleted at

  
const Ride = mongoose.model('Ride', ride_schema);

exports.Ride = Ride;
