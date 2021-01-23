var admin = require("firebase-admin");

var serviceAccount = require("./abren-272917-firebase-adminsdk-rmreh-633a6fe0de.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: "https://abren-272917.firebaseio.com"
});

exports.checkIfPhoneExists = async function(phone_number) {
    try {
        let user =  await admin.auth().getUserByPhoneNumber(phone_number); //TODO: Find a better way
        if(user){
            return true;
        }
    }catch(e){
        console.log(e);
        if(e.codePrefix == "auth"){
            return false;
        }else{
            throw new Error("Firebase Error");
        }        
    }
 };
