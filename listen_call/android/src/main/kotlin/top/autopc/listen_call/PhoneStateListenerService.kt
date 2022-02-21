package top.autopc.listen_call

import android.app.Service
import android.content.Context
import android.content.Intent
import android.os.Binder
import android.os.IBinder
import android.telephony.PhoneStateListener
import android.telephony.TelephonyManager
import android.util.Log
import io.flutter.embedding.engine.plugins.service.ServiceAware
import io.flutter.embedding.engine.plugins.service.ServicePluginBinding
private const val  TAG="PSLS";

class PhoneStateListenerService:  Service() {
    private lateinit var customPhoneStateListener:CustomPhoneStateListener
    private val mBinder: IBinder = PhoneStateListenerServiceBinder(this)

    override fun onBind(intent: Intent?): IBinder {
        Log.d(TAG,"on bind")
        customPhoneStateListener=CustomPhoneStateListener(applicationContext);
        val telephonyManagerService: TelephonyManager? = applicationContext.getSystemService(Context.TELEPHONY_SERVICE) as TelephonyManager?
        if (telephonyManagerService==null) Log.d(TAG,"telephonyManagerService init fail")
        else Log.d(TAG,"telephonyManagerService init success")
        telephonyManagerService?.listen(customPhoneStateListener,PhoneStateListener.LISTEN_CALL_STATE)
        return mBinder;
    }


}

class PhoneStateListenerServiceBinder(private val service: PhoneStateListenerService): Binder() {
    fun getService(): PhoneStateListenerService {
        return service
    }
}