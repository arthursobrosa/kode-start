import 'package:flutter/cupertino.dart';
import 'package:rick_morty/theme/text_type.dart';

class AppTitleWidget extends StatelessWidget {
  const AppTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Text('RICK AND MORTY API', style: TextType.spacedTitle.textSyle);
  }
}
