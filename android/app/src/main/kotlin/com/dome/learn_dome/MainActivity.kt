package com.dome.learn_dome

import android.os.Build
import android.util.Log
import androidx.annotation.RequiresApi
import com.dome.learn_dome.channel.EventChannelDome
import com.dome.learn_dome.channel.MethodChannelDome
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.BasicMessageChannel
import io.flutter.plugin.common.StandardMessageCodec

class MainActivity : FlutterActivity() {

    companion object {
        val TAG = MainActivity::class.java.simpleName
        const val BASIC_Message_Channel_Name = "com.dome/channel/basic"
    }

    //    用于注销WiFi广播监听
    private lateinit var eventChannelDome: EventChannelDome


    @RequiresApi(Build.VERSION_CODES.LOLLIPOP)
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
//        注册BasicMessageChannel
        BasicMessageChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            BASIC_Message_Channel_Name,
            StandardMessageCodec.INSTANCE
        ).apply {
            setMessageHandler { message, reply ->
                Log.d(TAG, "configureFlutterEngine: Basic Message Channel receive: ${message}")
//                reply返回一个响应数据
                reply.reply(
                    mapOf<String, Any>(
                        Pair("msg", "收到消息$message"),
                        Pair("code", 200),
                        Pair("data", listOf("Hello", "Flutter")),
                    )
                )
            }
            send("Flutter 你好") // 向Flutter发送数据，没有回调函数，无法接收Flutter返回的数据
//            向Flutter发送数据，有回调函数，接收Flutter返回的数据
            send("Flutter 你好，我可以接收数据") { message ->
                Log.d(TAG, "configureFlutterEngine: Send Message To Flutter And Receive: $message")
            }
        }

//        初始化MethodChannel
        MethodChannelDome(this, flutterEngine)

//        初始化EventChannel
        eventChannelDome = EventChannelDome(this, flutterEngine)
    }

    override fun onDestroy() {
        eventChannelDome.unregisterBroadcast() // 注销wifi广播
        super.onDestroy()
    }
}
