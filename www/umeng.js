const exec = require('cordova/exec');
const CDVUMeng = {
    open_one_key_auth:function (success,option){
        exec(success,null,'CDVUMeng','open_one_key_auth',[option]);
    },
    close_one_key_auth:function (){
        exec(null,null,'CDVUMeng','close_one_key_auth',[]);
    }
};
module.exports = CDVUMeng;
