import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rick_morty/theme/app_colors.dart';

enum TextType {
  appTitle,
  title,
  description,
  subDescription,
  textField,
  textFieldHint,
  button,
  selected,
}

extension TextTypeProperties on TextType {
  double get fontSize {
    switch (this) {
      case TextType.appTitle:
        return 14.5;
      case TextType.title:
        return 14.5;
      case TextType.description:
        return 12.5;
      case TextType.subDescription:
        return 12.5;
      case TextType.textField:
        return 12.5;
      case TextType.textFieldHint:
        return 12.5;
      case TextType.button:
        return 14.5;
      case TextType.selected:
        return 18;
    }
  }

  FontWeight get fontWeight {
    switch (this) {
      case TextType.appTitle:
        return FontWeight.w400; // regular
      case TextType.title:
        return FontWeight.w900; // black
      case TextType.description:
        return FontWeight.w500; // medium
      case TextType.subDescription:
        return FontWeight.w300; // light
      case TextType.textField:
        return FontWeight.w800; // bold
      case TextType.textFieldHint:
        return FontWeight.w300; // light
      case TextType.button:
        return FontWeight.w800; // bold
      case TextType.selected:
        return FontWeight.w800; // bold
    }
  }

  double get letterSpacing {
    switch (this) {
      case TextType.appTitle:
        return fontSize * 0.165;
      case TextType.selected:
        return fontSize * 0.165;
      default:
        return 0;
    }
  }

  Color get color {
    switch (this) {
      case TextType.selected:
        return AppColors.primaryColor;
      default:
        return AppColors.labelColor;
    }
  }

  TextStyle get textSyle => GoogleFonts.lato(
    color: color,
    fontSize: fontSize,
    fontWeight: fontWeight,
    letterSpacing: letterSpacing,
  );
}
