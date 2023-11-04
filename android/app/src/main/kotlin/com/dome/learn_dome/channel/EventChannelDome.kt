package com.dome.learn_dome.channel

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.net.wifi.WifiManager
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.EventChannel.EventSink
import io.flutter.plugin.common.EventChannel.StreamHandler

class EventChannelDome(private val context: Context, private val flutterEngine: FlutterEngine) {

    companion object {
        val TAG = EventChannelDome::class.java.simpleName
        const val EVENT_CHANNEL_NAME = "com.dome/channel/event"
    }

    private lateinit var eventChannel: EventChannel

    private var eventSink: EventSink? = null

    private val wifiBroadcastReceiver = object : BroadcastReceiver() {
        override fun onReceive(context: Context?, intent: Intent?) {
            intent?.apply {
                val wifiState =
                    getIntExtra(WifiManager.EXTRA_WIFI_STATE, WifiManager.WIFI_STATE_UNKNOWN)
                when (wifiState) {
                    WifiManager.WIFI_STATE_ENABLED -> {
                        eventSink?.success("WiFi 已开启")
                    }

                    WifiManager.WIFI_STATE_DISABLED -> {
                        eventSink?.success("WiFi 已关闭")
                    }

                    WifiManager.WIFI_STATE_UNKNOWN -> {
                        eventSink?.success("WiFi 状态未知")
                    }
                }
            }
        }
    }

    init {
        eventChannel =
            EventChannel(flutterEngine.dartExecutor.binaryMessenger, EVENT_CHANNEL_NAME).apply {
                setStreamHandler(object : StreamHandler {
                    override fun onListen(arguments: Any?, events: EventSink?) {
                        eventSink = events
                    }

                    override fun onCancel(arguments: Any?) {
                        eventSink = null
                    }
                })
            }
        val wifiIntentFilter = IntentFilter().apply {
            addAction(WifiManager.WIFI_STATE_CHANGED_ACTION)
        }
        context.registerReceiver(wifiBroadcastReceiver, wifiIntentFilter)
    }


    fun unregisterBroadcast() {
        context.unregisterReceiver(wifiBroadcastReceiver)
    }

}