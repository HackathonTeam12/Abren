const { Route } = require("../models/route");

exports.get = async function get(filter, fields, pagination) {
  let page = pagination.page || 1;
  let size = pagination.size || 15;
  const routes = await Route.find(filter, fields, {
    skip: (page - 1) * size,
    limit: size * 1,
  });

  return routes;
};

exports.get_one = async function get_one(id) {
  let route = Route.findById(id);
  return route;
};

exports.create = async function create(data) {
  let route = new Route(data);
  await route.save();
  return route;
};

exports.update = async function update(id, data) {
  let route = await Route.findOneAndUpdate({ _id: id }, data, {
    new: true,
    runValidators: true,
  });
  return route;
};
