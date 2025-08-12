import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:rick_morty/theme/app_colors.dart';
import 'package:rick_morty/theme/text_type.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.appBarColor,
      child: ListView(
        children: [
          ListTile(
            title: Text(
              'Item 1',
              style: TextType.appTitle.textSyle,
            ),
            onTap: () => Void,
          ),
          ListTile(
            title: Text(
              'Item 2',
              style: TextType.appTitle.textSyle,
            ),
            onTap: () => Void,
          ),
          ListTile(
            title: Text(
              'Item 3',
              style: TextType.appTitle.textSyle,
            ),
            onTap: () => Void,
          )
        ],
      ),
    );
  }
}