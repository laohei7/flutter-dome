import 'package:flutter/material.dart';
import 'package:learn_dome/controller/main_side_menu_controller.dart';
import 'package:learn_dome/screen/channel/basic_message_channel_screen.dart';
import 'package:learn_dome/screen/channel/method_channel_screen.dart';
import 'package:learn_dome/screen/error/error_screen.dart';
import 'package:learn_dome/screen/main/main_screen.dart';
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
      initialRoute: MainScreen.route,
      onGenerateRoute: (settings) {
        final widget = _buildWidgetBySettings(settings);
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
    Widget? widget;
    switch (route) {
      case MainScreen.route:
        widget = _buildProviderForWidget<MainSideMenuController>(
          MainSideMenuController(),
          const MainScreen(),
        );
        break;
      case BasicMessageChannelScreen.route:
        widget = const BasicMessageChannelScreen();
        break;
      case MethodChannelScreen.route:
        widget = const MethodChannelScreen();
        break;
      default:
        widget = const ErrorScreen();
        break;
    }
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
