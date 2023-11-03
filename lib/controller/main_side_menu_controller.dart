import 'package:flutter/material.dart';
import 'package:learn_dome/model/side_menu_model.dart';
import 'package:learn_dome/screen/channel/basic_message_channel_screen.dart';

class MainSideMenuController extends ChangeNotifier {
  final _menus = <SideMenuModel>[
    SideMenuModel(0, "BasicMessageChannel", "",
        widget: const BasicMessageChannelScreen()),
    SideMenuModel(1, "MethodChannel", "", widget: const Text("MethodChannel")),
    SideMenuModel(2, "EventChannel", "", widget: const Text("EventChannel")),
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
