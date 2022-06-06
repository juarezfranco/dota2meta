import 'package:flutter/material.dart';

class AppTheme {
  static const fontFamily = "Comfortaa";

  final BuildContext context;

  AppTheme._(this.context);

  static of(BuildContext context) => AppTheme._(context);

  Color get primaryColor => Colors.red;

  Color get secondaryColor => Colors.grey;

  ThemeData theme() {
    final theme = ThemeData(
      fontFamily: fontFamily,
      primaryColor: primaryColor,
      brightness: Brightness.dark,
    );
    const shadows = [
      Shadow(
        offset: Offset(1, 1),
        blurRadius: 1.0,
        color: Colors.black12,
      )
    ];

    return theme.copyWith(
      primaryColor: Colors.red,
      appBarTheme: theme.appBarTheme.copyWith(
        // backgroundColor: primaryColor,
      ),
      progressIndicatorTheme: theme.progressIndicatorTheme.copyWith(
        color: Colors.grey,
      ),
      textTheme: theme.textTheme.copyWith(
        headline1: theme.textTheme.headline1!.copyWith(
          color: primaryColor,
          shadows: shadows,
        ),
        headline2: theme.textTheme.headline2?.copyWith(
          color: primaryColor,
          shadows: shadows,
        ),
        headline3: theme.textTheme.headline3?.copyWith(
          color: primaryColor,
          shadows: shadows,
        ),
        headline4: theme.textTheme.headline4?.copyWith(
          color: primaryColor,
          shadows: shadows,
        ),
      ),
      colorScheme: theme.colorScheme.copyWith(
        secondary: secondaryColor,
      ),
    );
  }
}
