import 'package:flutter/material.dart';

abstract class AppColors {
  static Color primaryColor(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    if (brightness == Brightness.dark) {
      return Color(0xff87A1FA);
    }

    return Color(0xff557AFF);
  }

  static Color secondaryColor(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    if (brightness == Brightness.dark) {
      return Color(0xff1C1B1F);
    }

    return Color(0xffE0E0E0);
  }

  static Color backgroundColor(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    if (brightness == Brightness.dark) {
      return Colors.black;
    }

    return Colors.white;
  }

  static Color labelColor(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    if (brightness == Brightness.dark) {
      return Colors.white;
    }

    return Colors.black;
  }

  static Color leftIconColor(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    if (brightness == Brightness.dark) {
      return Color(0xffE6E1E5);
    }

    return Color(0xffA0A0A5);
  }

  static Color rightIconColor(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    if (brightness == Brightness.dark) {
      return Color(0xffCAC4D0);
    }

    return Color(0xff7D7A80);
  }

  static Color baseShimmerColor(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    if (brightness == Brightness.dark) {
      return Colors.grey[900]!;
    }

    return Colors.grey[300]!;
  }

  static Color highlightShimmerColor(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    if (brightness == Brightness.dark) {
      return Colors.grey[850]!;
    }

    return Colors.grey[100]!;
  }
}