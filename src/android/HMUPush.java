package hmyd.upush.cordova;

import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CallbackContext;

import android.content.SharedPreferences;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/**
 * This class echoes a string called from JavaScript.
 */
public class HMUPush extends CordovaPlugin {

    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        if (action.equals("getRemoteNotificationsDeviceId")) {
          SharedPreferences sp = cordova.getActivity().getSharedPreferences("umToken", 0);
          String deviceId = sp.getString("deviceId", "");
          this.getRemoteNotificationsDeviceId(deviceId, callbackContext);
          return true;
        }
        return false;
    }

    private void getRemoteNotificationsDeviceId(String message, CallbackContext callbackContext) {
        if (message != null && message.length() > 0) {
            callbackContext.success(message);
        } else {
            callbackContext.error("Expected one non-empty string argument.");
        }
    }
}
