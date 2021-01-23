const { User } = require("../models/user");
const bcrypt = require("bcrypt");

exports.get = async function get(filter, fields, pagination) {
  let page = pagination.page || 1;
  let size = pagination.size || 15;
  const users = await User.find(filter, fields, {
    skip: (page - 1) * size,
    limit: size * 1,
  });

  return users;
};

exports.get_one = async function get_one(options) {
  let user;
  if (options.id) {
    user = User.findById(options.id);
  } else if (options.phone_number) {
    user = User.findOne({ phone_number: options.phone_number });
  }

  return user;
};

exports.create = async function create(data) {
  let user = new User(data);
  // user.password = await bcrypt.hash(data.password, 10);
  await user.save();

  const token = user.generateAuthToken();

  return {
    user: user,
    token: token,
  };
};

exports.update = async function update(id, data) {
  let user = await User.findOneAndUpdate({ _id: id }, data, {
    new: true,
    runValidators: true,
  });
  return user;
};
