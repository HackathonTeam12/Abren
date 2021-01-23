const mongoose = require("mongoose");
const jwt = require('jsonwebtoken');
require('dotenv').config();

const user_schema = new mongoose.Schema({
  phone_number: { //TODO: Add username
    type: String,
    minlength: 10, 
    maxlength: 13,
    unique: true,
    index: true,
    required: true,
    validate: /^[+][0-9]*$/,
  },
  username : {
    type: String,
    minlength: 3,
    maxlength: 50,
    unique: true,
    // required: true,
  },
  name: {
      first_name : {
        type: String,
        minlength: 3,
        maxlength: 50,
        required: true,
      },
      fathers_name : {
        type: String,
        minlength: 3,
        maxlength: 50,
        required: true,
      }
  },  
  // password: {
  //   type: String,
  //   minlength: 6, //TODO: Validate more and in controller
  //   required: true,
  // },
  role: {
    type: String,
    enum: ["RIDER", "DRIVER", "ADMIN"],
    required: true,
    default: "RIDER"
  },
  status: {
    type: String,
    enum: ["PENDING", "VERIFIED", "DECLINED"],
    required: true,
    default: "PENDING"
  },
  gender: {
    type: String,
    enum: ["MALE", "FEMALE"],
    required: true,
  },
  age_group: {
    type: String,
    enum: ["18-25", "25-50", ">50"], //TODO: Decide on age groups
    required: true,
  },
  emergency_phone_number: {
    type: String,
    minlength: 10, //TODO: Validate more and not same with phone number
    maxlength: 13,
    validate: /^[+][0-9]*$/,
    required: true,
  },
  profile_picture_url: {
    type: String,
    required: false
  },
  id_card_url: {
    type: String,
    // required: true
  },
  preferences: {
    type : [
        {
            age_group:{
                type: String,
                enum: ["18-25", "25-50", ">50"] 
            },
            female: {
                type: Boolean,
                default: false
            },
            male: {
              type: Boolean,
              default: false
          }
        }
    ],
    maxlength: 3
  },
  car_information: {
    type: {
        type: String //TODO: Model? Enum?
    },
    color: {
        type: String //TODO: Enum?
    },
    license_plate_number: {
        type: String
    }
  },
  rating: {
      type: Number,
      default: 0,
      max: 5,
      min: 0
  },
  rides_taken: {
    type: Number,
    default: 0
  },
  rides_given: {
    type: Number,
    default: 0
  },
  people_given_ride: {
    type: Number,
    default: 0
  }  
}, {timestamps: {createdAt: "created_at", updatedAt: "updated_at"}}); //TODO: Deleted at

user_schema.methods.generateAuthToken = function() { 
    const token = jwt.sign({ _id: this._id, role: this.role}, process.env.APP_SECRET_KEY); 
    return token;
}
  
const User = mongoose.model('User', user_schema);

exports.User = User;
