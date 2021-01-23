const mongoose = require("mongoose");

require("dotenv").config();

const route_schema = new mongoose.Schema(
  {
    start_location: {
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
    destination_location: {
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
    way_points: {
      type: [
        { 
          name: {
            type: String,
          },
          latitude: {
            type: Number,
          },
          longitude: {
            type: Number,
          },
        }       
      ]      
    },
    driver_id: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
      required: true
    },
    last_taken: {
      type: Date,
    },
  },
  { timestamps: { createdAt: "created_at", updatedAt: "updated_at" } }
); //TODO: Deleted at

const Route = mongoose.model("Route", route_schema);

exports.Route = Route;
