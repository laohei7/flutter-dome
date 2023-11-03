import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:learn_dome/widget/empty_widget.dart';
import 'package:learn_dome/widget/input_widgets.dart';

class BasicMessageChannelScreen extends StatefulWidget {
  const BasicMessageChannelScreen({super.key});

  static const route = "/channel/basic";

  @override
  State<BasicMessageChannelScreen> createState() =>
      _BasicMessageChannelScreenState();
}

class _BasicMessageChannelScreenState extends State<BasicMessageChannelScreen> {
  // 定义通道名称
  final basicMessageChannelName = "com.dome/channel/basic";

  // 创建BasicMessageChannel
  late BasicMessageChannel basicMessageChannel;
  late TextEditingController textEditingController;

  String msg = "";

  @override
  void initState() {
    super.initState();
    basicMessageChannel = BasicMessageChannel(
        basicMessageChannelName, const StandardMessageCodec());
    // 用于接收Android使用send()方法传递过来的数据，同Android的一样
    basicMessageChannel.setMessageHandler((message) async {
      print(message);
      return null; //TODO Android接收Flutter返回则值没有成功，原因暂未确定
    });
    textEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("向原生传递数据", style: Theme.of(context).textTheme.titleMedium),
          VerticalBox(),
          MessageSendInput(
            controller: textEditingController,
            hintText: "输入数据",
            prefixIcon: const Icon(Icons.message_rounded, color: Colors.white),
            suffixIcon: Card(
              elevation: 0,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: InkWell(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                onTap: () => sendMessage(),
                child: const Icon(Icons.send_rounded, color: Colors.blue),
              ),
            ),
          ),
          VerticalBox(),
          Text("收到原生平台消息:", style: Theme.of(context).textTheme.titleMedium),
          VerticalBox(),
          Text(msg, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }

  void sendMessage() async {
    // 使用send()方法发送数据，并等待返回的数据
    basicMessageChannel.send(textEditingController.text.trim()).then((value) {
      msg = value.toString();
      setState(() {});
    });
  }
}
