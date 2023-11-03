package com.dome.learn_dome

import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.BasicMessageChannel
import io.flutter.plugin.common.StandardMessageCodec

class MainActivity : FlutterActivity() {

    companion object {
        val TAG = MainActivity::class.java.simpleName
        const val BASIC_Message_Channel_Name = "com.dome/channel/basic"
    }


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
            send("Flutter 你好") // 向Flutter发送数据
        }
    }
}
