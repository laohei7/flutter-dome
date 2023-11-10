import 'package:flutter/material.dart';
import 'package:learn_dome/controller/main_side_menu_controller.dart';
import 'package:learn_dome/model/side_menu_model.dart';
import 'package:learn_dome/screen/channel/basic_message_channel_screen.dart';
import 'package:learn_dome/screen/channel/event_channel_screen.dart';
import 'package:learn_dome/screen/channel/method_channel_screen.dart';
import 'package:learn_dome/screen/error/error_screen.dart';
import 'package:learn_dome/screen/main/main_side_menu.dart';
import 'package:learn_dome/screen/route/route_screen.dart';
import 'package:learn_dome/widget/responsive_widget.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  static const route = "/";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ResponsiveWidget(
          desktop: _buildDesktopMainScreen(context),
          tablet: _buildDesktopMainScreen(context),
          mobile: _buildMobileMainScreen(context),
        ),
      ),
    );
  }

  Widget _buildDesktopMainScreen(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Selector<MainSideMenuController, int>(
            shouldRebuild: (_, __) => true,
            selector: (_, controller) => controller.selectId,
            builder: (_, selectId, __) {
              return MainSideMenu(
                onTap: (id) =>
                    context.read<MainSideMenuController>().selectId = id,
                items: context.read<MainSideMenuController>().menus,
                selectId: selectId,
              );
            },
          ),
        ),
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: PageView(
              controller: context.read<MainSideMenuController>().pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: context
                  .read<MainSideMenuController>()
                  .menus
                  .map((e) => e.widget!)
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileMainScreen(BuildContext context) {
    return MainSideMenu(
      onTap: (id) {
        String route = switch (id) {
          0 => BasicMessageChannelScreen.route,
          1 => MethodChannelScreen.route,
          2 => EventChannelScreen.route,
          3 => RouteScreen.route,
          _ => ErrorScreen.route,
        };
        Navigator.pushNamed(context, route);
      },
      items: context.select<MainSideMenuController, List<SideMenuModel>>(
          (value) => value.menus),
    );
  }
}
