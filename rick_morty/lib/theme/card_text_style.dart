import 'package:flutter/widgets.dart';
import 'package:rick_morty/theme/app_colors.dart';

enum CardTextStyle { title, description, subDescription }

extension CardTextStyleProperties on CardTextStyle {
  double get fontSize {
    switch (this) {
      case CardTextStyle.title:
        return 14.5;
      case CardTextStyle.description:
        return 12.5;
      case CardTextStyle.subDescription:
        return 12.5;
    }
  }

  FontWeight get fontWeight {
    switch (this) {
      case CardTextStyle.title:
        return FontWeight.w900; // black
      case CardTextStyle.description:
        return FontWeight.w500; // medium
      case CardTextStyle.subDescription:
        return FontWeight.w300; // light
    }
  }

  double get letterSpacing => 0;

  TextStyle get textSyle => TextStyle(
    fontSize: fontSize,
    fontWeight: fontWeight,
    letterSpacing: letterSpacing,
    color: AppColors.textColor,
  );
}
