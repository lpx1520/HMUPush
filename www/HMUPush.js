var exec = require('cordova/exec');

exports.getRemoteNotificationsDeviceId = function (success, error) {
    exec(success, error, 'HMUPush', 'getRemoteNotificationsDeviceId', null);
};
