const jwt = require("jsonwebtoken");
const UserDal = require("../dal/user");
const roles = require('../roles.js');
const firebase_admin = require('../firebase_admin.js');

exports.verify_token = async function(req, res, next) {
  const header = req.headers["x-access-token"] || req.headers["authorization"];
  const token = header.split(" ")[1];
  try {
    const decoded = jwt.verify(token, process.env.APP_SECRET_KEY);
    req.user_id = decoded;
    const user = await UserDal.get_one({ id: req.user_id });
    const firebaseCheck = await firebase_admin.checkIfPhoneExists(user.phone_number);
    console.log(firebaseCheck);
    if(!firebaseCheck) return res.status(401).send("Access denied. Phone Number not Verified.");
    next();
  } catch (ex) {
    console.log(ex);
    res.status(400).send("Access denied. Invalid token.");
  }
};

exports.grant_access = function(action, resource) {
  return async (req, res, next) => {
   try {
    let user = await UserDal.get_one({id: req.user_id});
    const permission = roles.can(user.role)[action](resource);
    if (!permission.granted) {
     return res.status(401).send("You don't have permission to perform this action");
    }
    next()
   } catch (error) {
    next(error)
   }
  }
}