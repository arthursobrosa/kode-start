import 'package:flutter/material.dart';
import 'package:rick_morty/pages/settings_page.dart';

class SettingsTileWidget extends StatelessWidget {
  const SettingsTileWidget({
    super.key,
    required this.textStyle,
  });

  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          Icon(Icons.settings),

          SizedBox(width: 10),

          Text('Settings', style: textStyle),
        ],
      ),
      onTap: () {
        Navigator.of(context).pushNamed(SettingsPage.routeId);
      },
    );
  }
}