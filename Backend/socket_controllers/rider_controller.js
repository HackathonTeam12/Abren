const RequestDal = require("../dal/request");
const RideDal = require("../dal/ride");
const UserDal = require("../dal/user");
const otp_generator = require('otp-generator');

module.exports = function driver_events_handler(io, event_emitter){
    const rider_nsp = io.of("/rider");

    rider_nsp.on("connection", function (socket) {
        console.log("Rider Connected");
        let request = {};
        let user = {};
        let user_info = {};
        socket.on("register_request", async function (data) {
            console.log("register_request");
            console.log(data);
            let request_data = {
                rider_id: data.rider_id,
                rider_location: {
                    latitude: data.latitude,
                    longitude: data.longitude
                },
                destination: {
                    name: data.destination_name,
                    latitude: data.destination_latitude,
                    longitude: data.destination_longitude
                }
            }
            request = await RequestDal.create(request_data);
            socket.emit("request_registered", request);
            user = await UserDal.get_one({id: data.rider_id});
            user_info = {
                gender: user.gender,
                age_group: user.age_group
            }
            let rides = await RideDal.get({status: "ACTIVE"}, {}, {});
            rides.filter(async (ride) => {
                let current_user = await UserDal.get_one({id: ride.driver_id});
                let current_user_info = {
                    gender: current_user.gender,
                    age_group: current_user.age_group
                };
                return current_user.preferences.includes(user_info) && user.preferences.includes(current_user_info);
            });
            socket.emit("nearby_rides", rides);
        });
        socket.on("location_updated", async function (data) {
            console.log("location_updated");
            console.log(data);
            let rider_location = {
                latitude: data.latitude,
                longitude: data.longitude
            }
            request = await RequestDal.update(request.id, {rider_location: rider_location});
        });

        let rideWatch = RideDal.watch_changes({status: "ACTIVE"}); //TODO: Watch nearby rides

        rideWatch.on("change", async function () {
            let rides = await RideDal.get({status: "ACTIVE"}, {}, {});
            rides.filter(async (ride) => {
                let current_user = await UserDal.get_one({id: ride.driver_id});
                let current_user_info = {
                    gender: current_user.gender,
                    age_group: current_user.age_group
                };
                return current_user.preferences.includes(user_info) && user.preferences.includes(current_user_info);
            });
            socket.emit("nearby_rides", rides); //TODO: Don't send car information, stop sending once accepted
        });


        if(request != null){
            let requestedRidesWatch = RideDal.watch_changes({status: "ACTIVE", _id: {$in: request.rides}}); //TODO: Watch nearby rides

            requestedRidesWatch.on("change", async function () {
                let rides = await RideDal.get({status: "ACTIVE", _id: {$in: request.rides}}, {}, {});
                socket.emit("requested_rides_update", rides);
            });

            event_emitter.on("request_accepted", async function(ride_id, request_id) {
                if(request_id == request._id){
                    console.log("Request accepted in rider");
                     let otp = otp_generator.generate(4, {alphabets: false, upperCase: false, specialChars: false}); //TODO: Generate when created
                     request = await RequestDal.update(request._id, {accepted_ride: ride_id, status: "ACCEPTED", otp: {code: otp, date_created: Date.now(), is_validated : false}});
                     let ride = await RideDal.get_one({id: ride_id}, {});            
                     socket.emit("request_accepted", {ride: ride, otp: otp});
                     socket.emit("requested_rides_update", []);
                }            
            });

            event_emitter.on("otp_validated", async function(request_id){
                console.log("Otp validated at rider");
                console.log(request_id.toString() == request._id.toString());
                if(request_id.toString() == request._id.toString()){
                    let otp = {
                        code: request.otp.code,
                        date_created: request.otp.date_created,
                        is_validated: true
                    }
                    request = await RequestDal.update(request._id, {otp: otp, status: "HISTORY"});
                    user = await UserDal.update(user._id, {rides_taken: user.rides_taken + 1});
                    socket.emit("otp_validated", request);
                }
            });
    
        }
        
        socket.on("request_sent", async function (data){
            console.log("request_sent");
            console.log(data);
            let requestedRides = [data.ride_id]; //TODO: Handle multiple
            request = await RequestDal.update(request._id, {rides: requestedRides});
            let rides = await RideDal.get({status: "ACTIVE", _id: {$nin: request.rides}}, {}, {});
            rides.filter(async (ride) => {
                let current_user = await UserDal.get_one({id: ride.driver_id});
                let current_user_info = {
                    gender: current_user.gender,
                    age_group: current_user.age_group
                };
                return current_user.preferences.includes(user_info) && user.preferences.includes(current_user_info);
            });
            socket.emit("nearby_rides", rides); 
            rides = await RideDal.get({status: "ACTIVE", _id: {$in: request.rides}}, {}, {});
            socket.emit("requested_rides_update", rides);
        });
       

       socket.on("canceled", async function (){
            request = await RequestDal.update(request._id, {status: "CANCELED"});
       }); 

       socket.on("disconnect", async function (){
            console.log("Rider Disconnected");
            request = await RequestDal.update(request._id, {status: "CANCELED"}); //TODO: Check if ride did take place
            socket.conn.close();
        });
    });
}
