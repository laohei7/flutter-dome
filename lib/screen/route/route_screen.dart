import 'package:flutter/material.dart';
import 'package:learn_dome/screen/route/route_navigator_screen.dart';
import 'package:learn_dome/widget/empty_widget.dart';

class RouteScreen extends StatefulWidget {
  const RouteScreen({super.key});

  static const route = "/route";

  @override
  State<RouteScreen> createState() => _RouteScreenState();
}

class _RouteScreenState extends State<RouteScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          MaterialButton(
            onPressed: () async {
              // 直接使用push跳转，此方法不需要在MaterialApp中定义routes或者动态路由
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const RouteNavigatorScreen()),
              ).then((value) => showSnackBarToast(value));
            },
            child: const Text("普通跳转"),
          ),
          VerticalBox(),
          MaterialButton(
            onPressed: () async {
              // 直接使用push跳转，使用RouteNavigatorScreen的可选参数params传递数据
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const RouteNavigatorScreen(
                    params: {"msg": "Hello Flutter!!!"},
                  ),
                ),
              ).then((value) => showSnackBarToast(value));
            },
            child: const Text("普通跳转且传递参数（构造函数）"),
          ),
          VerticalBox(),
          MaterialButton(
            onPressed: () async {
              // 设置需要传递的参数
              const settings = RouteSettings(arguments: "Hello Flutter");
              // 直接使用push跳转，并用RouteSettings的arguments参数传递数据
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const RouteNavigatorScreen(),
                  settings: settings,
                ),
              ).then((value) => showSnackBarToast(value));
            },
            child: const Text("普通跳转且传递参数（arguments参数）"),
          ),
          VerticalBox(),
          MaterialButton(
            onPressed: () async {
              // 使用pushNamed方法跳转，需要在MaterialApp中定义routes或者动态路由。
              // 可以使用arguments参数传递对象，如果使用的是动态路由，可以在动态路由中转换数据，通过构造函数传递数据
              Navigator.pushNamed(
                context,
                RouteNavigatorScreen.route,
                arguments: {"msg": "Hello World!!!"},
              ).then((value) => showSnackBarToast(value));
            },
            child: const Text("动态路由跳转含参数传递"),
          ),
          VerticalBox(),
        ],
      ),
    );
  }

  void showSnackBarToast(Object? object) {
    if (object != null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("$object")));
    }
  }
}
