const mongoose = require("mongoose");
require("dotenv").config();

const request_schema = new mongoose.Schema(
  {
    //TODO: Revisit
    rider_id: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
    },
    rider_location: {
      latitude: {
        type: Number,
        // required: true,
      },
      longitude: {
        type: Number,
        // required: true,
      },
    },
    destination: {
      name: {
        type: String,
        required: true,
      },
      latitude: {
        type: Number,
        required: true,
      },
      longitude: {
        type: Number,
        required: true,
      },
    },
    rides: {
      type: [
          {
            type: mongoose.Schema.Types.ObjectId,
            ref: "Ride",
          },
      ],
    },
    accepted_ride: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Ride",
    },
    otp: {
      code: {
        type: String,
      },
      date_created: {
        type: Date
      },
      is_validated: {
        type: Boolean,
        default: false
      }
    },
    status: {
      type: String,
      enum: ["ACTIVE", "ACCEPTED", "CANCELED", "HISTORY"],
      default: "ACTIVE",
    },
  },
  { timestamps: { createdAt: "created_at", updatedAt: "updated_at" } }
); //TODO: Deleted at

const Request = mongoose.model("Request", request_schema);

exports.Request = Request;
