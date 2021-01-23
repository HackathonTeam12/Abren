const { Ride } = require("../models/ride");

exports.get = async function get(filter, fields, options) {
    let page = 1;
    let size = 15;
    if(options.pagination){
        page = options.pagination.page || page;
        size = options.pagination.size || size;
    }
    
    let populate = options.populate || {
        path: 'driver_id',
        select: 'username gender age_group rating car_information'
    };
    const rides = await Ride.find(
        filter,
        fields,
        { skip: (page - 1) * size, limit: size * 1 }
      ).populate(populate).populate('route_id'); //TODO: Make better

    return rides;
}

exports.get_one = async function get_one(query, options) { 
    let ride;
    let populate = options.populate || {
        path: 'driver_id',
        select: 'username gender age_group rating car_information'
    };
    if(query.id){
        ride = Ride.findById(query.id).populate(populate).populate('route_id');
    }else if(options.driver_id){
        ride = await Ride.findOne({driver_id : query.driver_id}).populate(populate).populate('route_id');
    }

    return ride;
}

exports.create = async function create(data) { 
    let ride = new Ride(data);
    await ride.save();
    return ride;
}

exports.update = async function update(id, data) { 
    let ride = await Ride.findOneAndUpdate({_id: id}, data, {new: true, runValidators: true});
    return ride;
}

exports.watch_changes = function watch_changes(pipeline) { 
    return Ride.watch(pipeline);
}