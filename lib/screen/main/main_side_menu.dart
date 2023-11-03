import 'package:flutter/material.dart';
import 'package:learn_dome/model/side_menu_model.dart';

class MainSideMenu extends StatelessWidget {
  const MainSideMenu(
      {super.key, required this.items, required this.onTap, this.selectId});

  final List<SideMenuModel> items;
  final int? selectId;
  final void Function(int id) onTap;

  @override
  Widget build(BuildContext context) {
    print(selectId);
    return ListView.builder(
      itemBuilder: (_, index) {
        final item = items[index];
        switch (item.type) {
          case SideMenuType.header:
            return const Placeholder();
          case SideMenuType.item:
            return ListTile(
              onTap: () => onTap(item.id),
              selected: selectId == null ? false : selectId == item.id,
              selectedTileColor: Colors.greenAccent,
              title: Text(
                item.title,
                style: Theme.of(context).textTheme.labelLarge,
              ),
            );
          case SideMenuType.footer:
            return const Placeholder();
        }
      },
      itemCount: items.length,
    );
  }
}
