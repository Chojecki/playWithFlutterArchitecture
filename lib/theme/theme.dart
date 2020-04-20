import 'package:flutter/material.dart';

class ArchSampleTheme {
  static ThemeData get theme {
    final themeData = ThemeData.light();
    final textTheme = themeData.textTheme;
    final body1 = textTheme.body1.copyWith(
      decorationColor: Colors.transparent,
    );

    return ThemeData.light().copyWith(
      primaryColor: Colors.blue[900],
      accentColor: Colors.pink[300],
      buttonColor: Colors.grey[800],
      textSelectionColor: Colors.pink[100],
      toggleableActiveColor: Colors.pink[300],
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.pink[300],
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: themeData.dialogBackgroundColor,
        contentTextStyle: body1,
        actionTextColor: Colors.pink[300],
      ),
      textTheme: textTheme.copyWith(
        body1: body1,
      ),
    );
  }
}
