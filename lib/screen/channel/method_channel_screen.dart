import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:learn_dome/widget/empty_widget.dart';
import 'package:package_info_plus/package_info_plus.dart';

class MethodChannelScreen extends StatefulWidget {
  const MethodChannelScreen({super.key});

  static const route = "/channel/method";

  @override
  State<MethodChannelScreen> createState() => _MethodChannelScreenState();
}

class _MethodChannelScreenState extends State<MethodChannelScreen> {
  final methodChannelName = "com.dome/channel/method";

  late MethodChannel methodChannel;

  String electricQuantity = "--";

  @override
  void initState() {
    super.initState();
    methodChannel = MethodChannel(methodChannelName);
    // 用于处理原生平台调用Flutter方法
    methodChannel.setMethodCallHandler((call) async {
      switch (call.method) {
        case "getVersion":
          return await getVersion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("调用原生方法", style: Theme.of(context).textTheme.titleMedium),
          Row(
            children: [
              Expanded(
                child: MaterialButton(
                  // 调用原生平台方法获取电池电量
                  onPressed: () async =>
                      methodChannel.invokeMethod("getElectricQuantity").then(
                    (value) {
                      electricQuantity = value.toString();
                      setState(() {});
                    },
                  ),
                  color: Colors.greenAccent,
                  child: Text(
                    "获取电量",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
              ),
              HorizontalBox(),
              Expanded(
                flex: 3,
                child: Text(
                  "当前电量: $electricQuantity%",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<String> getVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }
}
