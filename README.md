# HMUPush

UMPush for Cordova Plugin

声明：本插件非友盟提供。

实现功能：

1：仅集成iOS、Android友盟推送。

2：获取到设备的deviceId


添加： 
cordova plugin add https://github.com/lpx1520/HMUPush.git --variable APP_KEY_I={iOS的Appkey} --variable APP_KEY_A={andriod的Appkey}  --variable APP_SECRET={andriod的App_secret}

移除：
ionic cordova plugin rm hmyd-upush-cordova


注意：
安卓如果无法获取到device token，并且log中显示"accs bindapp error!  accs.taobaoregister: onbindapp errorcode:-11"
请参考http://bbs.umeng.com/thread-23018-1-1.html
