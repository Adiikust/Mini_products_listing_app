import '../../core/constants/exports.dart';

class AppTheme {
  static ThemeData lightThemeData = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.black,
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: Colors.black,
      selectionColor: Colors.blue.withValues(alpha: 0.4),
      selectionHandleColor: Colors.blue,
    ),
    textTheme: textTheme,
  );
}
