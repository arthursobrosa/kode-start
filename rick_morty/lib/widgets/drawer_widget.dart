import 'package:flutter/material.dart';
import 'package:rick_morty/theme/app_colors.dart';

class DrawerWidget extends StatelessWidget {
  final List<Widget> items;

  const DrawerWidget({
    super.key,
    required this.items
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.appBarColor,
      child: ListView(
        children: [
          ...items
          // ListTile(
          //   title: Text('Item 1', style: TextType.appTitle.textSyle),
          //   onTap: () => Void,
          // ),
          // ListTile(
          //   title: Text('Item 2', style: TextType.appTitle.textSyle),
          //   onTap: () => Void,
          // ),
          // ListTile(
          //   title: Text('Item 3', style: TextType.appTitle.textSyle),
          //   onTap: () => Void,
          // ),
        ],
      ),
    );
  }
}
