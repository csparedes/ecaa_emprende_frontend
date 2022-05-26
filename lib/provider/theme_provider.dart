import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData currentTheme;
  Color theColor = const Color.fromARGB(255, 32, 136, 35);
  ThemeProvider({required bool isDarkMode})
      : currentTheme = isDarkMode
            ? ThemeData.dark().copyWith(
                primaryColor: Colors.green,
                appBarTheme: const AppBarTheme(
                  backgroundColor: Color.fromARGB(255, 32, 136, 35),
                ),
                floatingActionButtonTheme: const FloatingActionButtonThemeData(
                    backgroundColor: Color.fromARGB(255, 32, 136, 35)),
              )
            : ThemeData.light().copyWith(
                appBarTheme: const AppBarTheme(
                  backgroundColor: Color.fromARGB(255, 32, 136, 35),
                ),
                floatingActionButtonTheme: const FloatingActionButtonThemeData(
                    backgroundColor: Color.fromARGB(255, 32, 136, 35)),
              );

  setLightMode() {
    currentTheme = ThemeData.light().copyWith(
      primaryColor: Colors.green,
      appBarTheme: AppBarTheme(
        backgroundColor: theColor,
      ),
      floatingActionButtonTheme:
          FloatingActionButtonThemeData(backgroundColor: theColor),
    );
    notifyListeners();
  }

  setDarkMode() {
    currentTheme = ThemeData.dark().copyWith(
      primaryColor: Colors.green,
      appBarTheme: AppBarTheme(
        backgroundColor: theColor,
      ),
      floatingActionButtonTheme:
          FloatingActionButtonThemeData(backgroundColor: theColor),
    );
    notifyListeners();
  }
}
