import 'package:flutter/widgets.dart';
import 'package:rick_morty/theme/app_colors.dart';

enum CardTextType { title, description, subDescription }

extension CardTextTypeProperties on CardTextType {
  double get fontSize {
    switch (this) {
      case CardTextType.title:
        return 14.5;
      case CardTextType.description:
        return 12.5;
      case CardTextType.subDescription:
        return 12.5;
    }
  }

  FontWeight get fontWeight {
    switch (this) {
      case CardTextType.title:
        return FontWeight.w900; // black
      case CardTextType.description:
        return FontWeight.w500; // medium
      case CardTextType.subDescription:
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
