import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rick_morty/theme/app_colors.dart';

enum TextType {
  spacedTitle,
  boldTitle,
  bodyRegular,
  bodySmall,
  inputText,
  inputPlaceholder,
  buttonText,
  highlighted,
}

extension TextTypeProperties on TextType {
  double get fontSize {
    switch (this) {
      case TextType.spacedTitle:
        return 14.5;
      case TextType.boldTitle:
        return 14.5;
      case TextType.bodyRegular:
        return 12.5;
      case TextType.bodySmall:
        return 12.5;
      case TextType.inputText:
        return 12.5;
      case TextType.inputPlaceholder:
        return 12.5;
      case TextType.buttonText:
        return 14.5;
      case TextType.highlighted:
        return 18;
    }
  }

  FontWeight get fontWeight {
    switch (this) {
      case TextType.spacedTitle:
        return FontWeight.w400; // regular
      case TextType.boldTitle:
        return FontWeight.w900; // black
      case TextType.bodyRegular:
        return FontWeight.w500; // medium
      case TextType.bodySmall:
        return FontWeight.w300; // light
      case TextType.inputText:
        return FontWeight.w800; // bold
      case TextType.inputPlaceholder:
        return FontWeight.w300; // light
      case TextType.buttonText:
        return FontWeight.w800; // bold
      case TextType.highlighted:
        return FontWeight.w800; // bold
    }
  }

  double get letterSpacing {
    switch (this) {
      case TextType.spacedTitle:
        return fontSize * 0.165;
      case TextType.highlighted:
        return fontSize * 0.165;
      default:
        return 0;
    }
  }

  Color color(BuildContext context) {
    switch (this) {
      case TextType.highlighted:
        return AppColors.primaryColor(context);
      default:
        return AppColors.labelColor(context);
    }
  }



  TextStyle textSyle(BuildContext context) => GoogleFonts.lato(
    color: color(context),
    fontSize: fontSize,
    fontWeight: fontWeight,
    letterSpacing: letterSpacing,
  );
}
