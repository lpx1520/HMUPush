package hmyd.upush.cordova;

import android.app.Application;
import android.widget.Toast;

import com.umeng.message.IUmengRegisterCallback;
import android.content.SharedPreferences;
import com.umeng.message.PushAgent;


/**
 * author: senseLo
 * date: 2017/12/12
 */

public class AppApplication extends Application {
    @Override
    public void onCreate() {
        super.onCreate();
        PushAgent mPushAgent = PushAgent.getInstance(this);
        //注册推送服务，每次调用register方法都会回调该接口
        mPushAgent.register(new IUmengRegisterCallback() {

            @Override
            public void onSuccess(String deviceToken) {
                //注册成功会返回device token
                SharedPreferences.Editor editor = getSharedPreferences("umToken", MODE_PRIVATE).edit();
                editor.putString("deviceId", deviceToken);
                editor.commit();
                Toast.makeText(getApplicationContext(), deviceToken,Toast.LENGTH_LONG);
            }

            @Override
            public void onFailure(String s, String s1) {

            }
        });
    }
}
