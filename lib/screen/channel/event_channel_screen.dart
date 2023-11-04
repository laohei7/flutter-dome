import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:learn_dome/widget/empty_widget.dart';

class EventChannelScreen extends StatefulWidget {
  const EventChannelScreen({super.key});

  static const route = "/channel/event";

  @override
  State<EventChannelScreen> createState() => _EventChannelScreenState();
}

class _EventChannelScreenState extends State<EventChannelScreen> {
  final eventChannelName = "com.dome/channel/event";

  late EventChannel eventChannel;

  String wifiState = "--";

  @override
  void initState() {
    super.initState();
    // 初始化EventChannel
    eventChannel = EventChannel(eventChannelName);

    // 注册事件广播监听
    eventChannel.receiveBroadcastStream().listen((event) {
      wifiState = event.toString();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("监听WiFi状态", style: Theme.of(context).textTheme.titleMedium),
          Row(
            children: [
              const Expanded(child: Icon(Icons.wifi)),
              HorizontalBox(),
              Expanded(
                flex: 3,
                child: Text(
                  "WiFi状态: $wifiState",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
