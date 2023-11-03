import 'package:flutter/material.dart';

class SideMenuModel {
  final int id;
  final String title;
  final String icon;
  final Widget? widget;
  final SideMenuType type;

  SideMenuModel(this.id, this.title, this.icon,
      {this.type = SideMenuType.item, this.widget});
}

enum SideMenuType { header, item, footer }
