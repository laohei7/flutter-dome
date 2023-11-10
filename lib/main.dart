import 'package:flutter/material.dart';
import 'package:learn_dome/controller/main_side_menu_controller.dart';
import 'package:learn_dome/screen/channel/basic_message_channel_screen.dart';
import 'package:learn_dome/screen/channel/event_channel_screen.dart';
import 'package:learn_dome/screen/channel/method_channel_screen.dart';
import 'package:learn_dome/screen/error/error_screen.dart';
import 'package:learn_dome/screen/main/main_screen.dart';
import 'package:learn_dome/screen/route/route_navigator_screen.dart';
import 'package:learn_dome/screen/route/route_screen.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),

      // 初始路由，效果同home参数，程序启动时第一个页面
      initialRoute: MainScreen.route,

      // 简单路由配置，k-v形式
      // routes: {
      //   MainScreen.route: (_) => const MainScreen(),
      // },

      // 动态路由配置，通过settings允许参数传递，路由拦截等功能
      onGenerateRoute: (settings) {
        // 获取需要跳转的页面
        final widget = _buildWidgetBySettings(settings);

        // 使用PageRouteBuilder自定义页面跳转动画，也可以使用MaterialPageRoute等默认的跳转动画。
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => widget,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            var tween = Tween(begin: begin, end: end);
            var offsetAnimation = animation.drive(tween);
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(position: offsetAnimation, child: child),
            );
          },
        );
      },
    );
  }

  Widget _buildWidgetBySettings(RouteSettings settings) {
    final route = settings.name;
    debugPrint(route);

    Widget widget = switch (route) {
      MainScreen.route => _buildProviderForWidget<MainSideMenuController>(
          MainSideMenuController(),
          const MainScreen(),
        ),
      BasicMessageChannelScreen.route => const BasicMessageChannelScreen(),
      MethodChannelScreen.route => const MethodChannelScreen(),
      EventChannelScreen.route => const EventChannelScreen(),
      RouteScreen.route => const RouteScreen(),
      RouteNavigatorScreen.route => RouteNavigatorScreen(
          params: settings.arguments != null
              ? settings.arguments as Map<String, dynamic>
              : null,
        ),
      _ => const ErrorScreen(),
    };
    return widget;
  }

  Widget _buildProviderForWidget<T extends ChangeNotifier>(
      T controller, Widget widget) {
    return ChangeNotifierProvider(
      create: (context) => controller,
      child: widget,
    );
  }
}
