import 'package:flutter/material.dart';
import 'package:learn_dome/model/side_menu_model.dart';
import 'package:learn_dome/screen/channel/basic_message_channel_screen.dart';
import 'package:learn_dome/screen/channel/event_channel_screen.dart';
import 'package:learn_dome/screen/channel/method_channel_screen.dart';

class MainSideMenuController extends ChangeNotifier {
  final _menus = <SideMenuModel>[
    SideMenuModel(0, "BasicMessageChannel", "",
        widget: const BasicMessageChannelScreen()),
    SideMenuModel(1, "MethodChannel", "", widget: const MethodChannelScreen()),
    SideMenuModel(2, "EventChannel", "", widget: const EventChannelScreen()),
  ];

  List<SideMenuModel> get menus => _menus;
  late int _selectId = menus.first.id;

  set selectId(int value) {
    _selectId = value;
    pageController.jumpToPage(selectId);
    notifyListeners();
  }

  int get selectId => _selectId;
  late final PageController _pageController =
      PageController(initialPage: _selectId);

  PageController get pageController => _pageController;
}
