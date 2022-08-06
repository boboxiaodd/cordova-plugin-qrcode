const exec = require('cordova/exec');
const CDVQRCode = {
    scan_qrcode:function (success){
        exec(success,null,'CDVQRCode','scan_qrcode',[]);
    }
};
module.exports = CDVQRCode;
