const AccessControl = require('accesscontrol');

const ac = new AccessControl();    

module.exports = (function() {

    ac.grant('RIDER')
        .readOwn('profile')
        .updateOwn('profile')
        .updateOwn('account')
      .grant('DRIVER')      
        .readOwn('profile')
        .updateOwn('profile')
        .create('ride')
      .grant("ADMIN")
        .readAny("comment")
        
    return ac;

})();