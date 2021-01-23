const { Request } = require("../models/request");

exports.get = async function get(filter, fields, options) {
    let page = 1;
    let size = 15;
    if(options.pagination){
        page = options.pagination.page || page;
        size = options.pagination.size || size;
    }
    let populate = options.populate || {
        path: 'rider_id',
        select: 'username gender age_group rating'
    }
    let requests = await Request.find(
        filter,
        fields,
        { skip: (page - 1) * size, limit: size * 1 }
      ).populate(populate);
    return requests;
}

exports.get_one = async function get_one(query, options) { 
    let request;
    let populate = options.populate || {
        path: 'rider_id',
        select: 'username gender age_group rating'
    }
    if(query.id){
        request = Request.findById(query.id).populate(populate);
    }else if(options.rider_id){
        request = Request.findOne({rider_id : query.rider_id}).populate(populate);
    }

    return request;
}

exports.create = async function create(data) { 

    let request = new Request(data);
    await request.save();
    return request;
}

exports.update = async function update(id, data) { 
    let request = await Request.findOneAndUpdate({_id: id}, data, {new: true, runValidators: true});
    return request;
}

exports.watch = function watch(pipeline) { 
    return Request.watch(pipeline);
}