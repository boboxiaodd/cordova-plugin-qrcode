const exec = require('cordova/exec');
const CDVQRCode = {
    scan_qrcode:function (option,success){
        exec(success,null,'CDVQRCode','scan_qrcode',[option]);
    }
};
module.exports = CDVQRCode;
