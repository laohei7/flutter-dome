package com.dome.learn_dome.channel

import android.content.Context
import android.os.BatteryManager
import android.os.Build
import android.util.Log
import androidx.annotation.RequiresApi
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

@RequiresApi(Build.VERSION_CODES.LOLLIPOP)
class MethodChannelDome(private val context: Context, private val flutterEngine: FlutterEngine) {
    companion object {
        val TAG = MethodChannelDome::class.java.simpleName
        const val METHOD_CHANNEL_NAME = "com.dome/channel/method"
        const val GET_ELECTRIC_QUANTITY = "getElectricQuantity"
        const val GET_VERSION = "getVersion"
    }

    init {
//        创建MethodChannel
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, METHOD_CHANNEL_NAME).apply {
//            添加setMethodCallHandler
            setMethodCallHandler { call, reply ->
                when (call.method) {
                    GET_ELECTRIC_QUANTITY -> {
                        val manager =
                            context.getSystemService(Context.BATTERY_SERVICE) as BatteryManager
                        reply.success(
                            manager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
                                .toString()
                        )
                    }

                    else -> {
                        reply.notImplemented()
                    }
                }
            }
            // Android调用Flutter获取版本
            invokeMethod(GET_VERSION, null, object : MethodChannel.Result {
                override fun success(result: Any?) {
                    Log.d(TAG, "success: version is $result")
                }

                override fun error(errorCode: String, errorMessage: String?, errorDetails: Any?) {
                    Log.d(TAG, "error: $errorMessage")
                }

                override fun notImplemented() {
                    Log.d(TAG, "notImplemented: ")
                }

            })
        }
    }
}