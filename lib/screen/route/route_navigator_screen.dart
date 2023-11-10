import 'package:flutter/material.dart';

class RouteNavigatorScreen extends StatelessWidget {
  const RouteNavigatorScreen({super.key, this.params});

  static const route = "/route/dome";

  final Map<String, dynamic>? params;

  @override
  Widget build(BuildContext context) {
    dynamic data;
    // 如果不使用构造函数传递数据，则从RouteSettings的arguments参数中获取
    if (params == null) {
      data = ModalRoute.of(context)?.settings.arguments;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("路由Dome"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (params != null) Text("params接收的数据: ${params!["msg"]}"),
            if (params == null) Text("arguments接收的数据: $data"),
            MaterialButton(
              onPressed: () {
                Navigator.pop(context, "这是返回的数据！！！");
              },
              child: const Text("返回上一页，并返回数据"),
            ),
          ],
        ),
      ),
    );
  }
}
