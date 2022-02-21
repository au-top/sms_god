package  top.autopc.listen_call

import android.content.Context
import android.telephony.PhoneStateListener
import android.telephony.ServiceState
import android.telephony.TelephonyManager
import android.util.Log

private const val TAG="CPSL";
/**
 * 来去电监听
 */
class CustomPhoneStateListener(private val mContext: Context) : PhoneStateListener() {
    override fun onServiceStateChanged(serviceState: ServiceState) {
        super.onServiceStateChanged(serviceState)
        Log.d(
            TAG,
            "CustomPhoneStateListener onServiceStateChanged: $serviceState"
        )
    }

    override fun onCallStateChanged(state: Int, incomingNumber: String) {
        super.onCallStateChanged(state, incomingNumber);
        Log.d(
            TAG, "CustomPhoneStateListener state: "
                    + state + " incomingNumber: " + incomingNumber
        )

        when (state) {
            TelephonyManager.CALL_STATE_IDLE -> {
                Log.d(TAG,"CALL_STATE_IDLE");
            }
            TelephonyManager.CALL_STATE_RINGING -> {
                Log.d(TAG,"CALL_STATE_RINGING");
            }
            TelephonyManager.CALL_STATE_OFFHOOK -> {
                Log.d(TAG,"CALL_STATE_OFFHOOK");
            }
        }
    }
}