const RequestDal = require("../dal/request");
const RideDal = require("../dal/ride");
const RouteDal = require("../dal/route");
const UserDal = require("../dal/user");

module.exports = function driver_events_handler(io, event_emitter){
    const driver_nsp = io.of("/driver");

    driver_nsp.on("connection", function (socket) {
        console.log("Driver Connected");
        let ride = {};
        let user = {};
        let ride_given = false;
        socket.on("register_ride", async function (data) {
            console.log("register_ride");
            console.log(data);
            let ride_data = {
                driver_id: data.driver_id,
                route_id: data.route_id,
                driver_location: {
                    latitude: 9.003817,
                    longitude: 38.815167
                }
            }
            user = await UserDal.get_one({id: data.driver_id});
            ride = await RideDal.create(ride_data);
            console.log(ride);
            socket.emit("ride_registered", ride);
        });
        socket.on("location_updated", async function (data) {
            console.log("location_updated");
            console.log(data);
            let driver_location = {
                latitude: data.latitude,
                longitude: data.longitude
            }
            ride = await RideDal.update(ride.id, {driver_location: driver_location}); //TODO: Trailing zeros?
        });

        if(ride != null){
            let requestWatch = RequestDal.watch({rides: ride._id, status: "ACTIVE"});

            requestWatch.on("change", async function () {
                let requests = await RequestDal.get({rides: ride._id, status: "ACTIVE"}, {}, {}); //TODO: Don't send otp and rides
                console.log("requests" + requests);
                socket.emit("requests_update", requests);
            });

            let acceptedWatch = RequestDal.watch({rides: ride._id, status: {$in: ["ACCEPTED", "HISTORY"]}});

            acceptedWatch.on("change", async function () {
                let accepted = await RequestDal.get({rides: ride._id, status: {$in: ["ACCEPTED", "HISTORY"]}}, {}, {}); //TODO: Don't send otp and rides
                console.log("accepted" + accepted);
                socket.emit("accepted_requests", accepted);
            });
        }        
        
        socket.on("request_accepted", async function (data){
            console.log("request_accepted");
            console.log(data);
            event_emitter.emit("request_accepted", ride._id, data.id);
            // let accepted = await RequestDal.get({accepted_ride: ride._id, status: "ACCEPTED"}, {}, {});
            // console.log("accepted: " + accepted);
            // socket.emit("accepted_requests", accepted);
        });

        socket.on("opt_sent", async function (data){ //TODO: Handle Error
            console.log("opt_sent");
            console.log(data);
            let date = new Date(Date.now());
            date.setHours(date.getHours() - 2);
            let accepted = await RequestDal.get({accepted_ride: ride._id, status: "ACCEPTED", "otp.code": data.otp, "otp.is_validated": false, "otp.date_created": { $gt: date }}, {}, {});
            // let accepted = await RequestDal.get({accepted_ride: ride._id, status: "ACCEPTED", "otp.code": data.otp, "otp.is_validated": false}, {}, {});
            if(accepted.length != 0){
                // console.log("accepted in otp:" + accepted);
                event_emitter.emit("otp_validated", accepted[0]._id);    
                user = await UserDal.update(user._id, {people_given_ride: user.people_given_ride + 1});
                if(!ride_given){
                    user = await UserDal.update(user._id, {rides_given: user.rides_given + 1});
                    ride_given = true;
                }    
                await RouteDal.update(ride.route_id, {last_taken: ride.created_at});        
            } 
            // socket.emit("accepted_requests", accepted);
        });

        socket.on("stopped", async function (){
            if(ride_given){
                ride = await RideDal.update(ride._id, {status: "HISTORY"});
            }else{
                ride = await RideDal.update(ride._id, {status: "CANCELED"});
            }
        });

        socket.on("canceled", async function (){
            ride = await RideDal.update(ride._id, {status: "CANCELED"});
        });
        
        socket.on("disconnect", async function (){
            console.log("Driver Disconnected");
            if(ride_given){
                ride = await RideDal.update(ride._id, {status: "HISTORY"});
            }else{
                ride = await RideDal.update(ride._id, {status: "CANCELED"});
            } //TODO: Check if ride did take place, continue ride
            socket.conn.close();
        });
    });
}

//TODO: Filter by preference    X
//TODO: Create ride and request here    X
//TODO: Update ride stats and route last taken  X
//TODO: Send route with rides   X
//TODO: Display user information with rides and requests   X
//TODO: Handle OTP  X
//TODO: Handle errors
//TODO: Handle reconnect
//TODO: Authorize
//TODO: Filter by location and destination



 