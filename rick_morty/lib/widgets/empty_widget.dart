import 'package:flutter/material.dart';
import 'package:rick_morty/theme/app_colors.dart';
import 'package:rick_morty/theme/app_image_paths.dart';
import 'package:rick_morty/theme/text_type.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    super.key,
    required this.text,
    required this.onTapButton,
    required this.textStyle,
    required this.buttonTextStyle,
    required this.buttonColor
  });

  final String? text;
  final Function() onTapButton;
  final TextStyle textStyle;
  final TextStyle buttonTextStyle;
  final Color buttonColor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text ?? 'Unknown error',
              style: textStyle,
              textAlign: TextAlign.center,
              maxLines: null,
              overflow: TextOverflow.visible,
            ),

            const SizedBox(height: 24),

            Image.asset(AppImagePaths.empty, height: 180, fit: BoxFit.contain),

            const SizedBox(height: 24),

            ElevatedButton(
              onPressed: onTapButton,
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
              ),
              child: Text('Refresh', style: buttonTextStyle),
            ),
          ],
        ),
      ),
    );
  }
}
