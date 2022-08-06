const exec = require('cordova/exec');
const CDVQRCode = {
    scan_qrcode:function (success){
        exec(success,null,'CDVUMeng','scan_qrcode',[]);
    }
};
module.exports = CDVQRCode;
