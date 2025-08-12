import 'package:flutter/cupertino.dart';

class AppTitleWidget extends StatelessWidget {
  final TextStyle textStyle;

  const AppTitleWidget({super.key, required this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Text('RICK AND MORTY API', style: textStyle);
  }
}
