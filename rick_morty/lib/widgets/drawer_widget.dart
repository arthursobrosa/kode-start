import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  final List<Widget> items;
  final Color backgroundColor;

  const DrawerWidget({
    super.key, 
    required this.items,
    required this.backgroundColor
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: backgroundColor,
      child: ListView(children: [...items]),
    );
  }
}
