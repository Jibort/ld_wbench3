// Controlador unificat per a la gestió de temes de l'aplicació.
// CreatedAt: 2025/03/07 dv.

import 'dart:ui';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ld_wbench3/core/ld_ctrl.dart';
import 'package:ld_wbench3/tools/debug.dart';

class LdThemeCtrl extends LdCtrl {
  // 📝 ESTÀTICS -----------------------
  static final LdThemeCtrl _single = LdThemeCtrl();
  static LdThemeCtrl get single => _single;

  static const className = "LdThemeCtrl";
  static const ctrlTag = "${className}_tag";

  // 🧩 MEMBRES ------------------------
  ThemeMode _themeMode = ThemeMode.system;
  bool _isDarkMode = false;

  // 🛠️ CONSTRUCTORS -------------------
  LdThemeCtrl() : super(pTag: ctrlTag) {
    // Detectar el mode actual del sistema
    _isDarkMode = Get.isDarkMode;

    // Inicialitzar _themeMode basat en la configuració del sistema
    _themeMode = Get.isDarkMode ? ThemeMode.dark : ThemeMode.light;

    // Si l'aplicació està seguint el tema del sistema
    if (Get.isPlatformDarkMode) {
      _themeMode = ThemeMode.system;
    }
  }

  // 📥 GETTERS/SETTERS ----------------
  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _isDarkMode;

  // COLORS constants per a referència
  static const Color primaryLight = Color(0xFF2196F3); // Blau
  static const Color primaryDark = Color(0xFF1565C0); // Blau fosc

  static const Color secondaryLight = Color(0xFFFF9800); // Taronja
  static const Color secondaryDark = Color(0xFFFF5722); // Taronja fosc

  static const Color backgroundLight = Color(0xFFF5F5F5); // Gris molt clar
  static const Color backgroundDark = Color(0xFF121212); // Gris molt fosc

  static const Color surfaceLight = Color(0xFFFFFFFF); // Blanc
  static const Color surfaceDark = Color(0xFF1E1E1E); // Gris fosc

  static const Color errorLight = Color(0xFFB00020); // Vermell
  static const Color errorDark = Color(0xFFCF6679); // Rosa vermellós

  // TEMES PREDEFINITS ================
  ThemeData get defaultTheme => (_isDarkMode) ? darkTheme : lightTheme;

  // Tema clar ------------------------
  ThemeData get lightTheme => _lightTheme;
  final ThemeData _lightTheme = ThemeData.light().copyWith(
    // Esquema de colors principals
    colorScheme: ColorScheme.light(
      primary: primaryLight,
      onPrimary: Colors.white,
      secondary: secondaryLight,
      onSecondary: Colors.black,
      // background: backgroundLight,
      // onBackground: Colors.black87,
      surface: surfaceLight,
      onSurface: Colors.black87,
      error: errorLight,
      onError: Colors.white,
    ),

    // Colors específics per a components
    scaffoldBackgroundColor: backgroundLight,
    appBarTheme: AppBarTheme(
      backgroundColor: primaryLight,
      foregroundColor: Colors.white,
      elevation: 4,
    ),
    cardTheme: CardTheme(
      color: surfaceLight,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryLight,
        foregroundColor: Colors.white,
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryLight,
      foregroundColor: Colors.white,
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.white,
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.shade400),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.shade400),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: primaryLight, width: 2),
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryLight;
        }
        return Colors.grey.shade400;
      }),
      checkColor: WidgetStateProperty.all(Colors.white),
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: primaryLight,
      linearTrackColor: Colors.grey.shade200,
    ),
  );

  // Tema fosc ------------------------
  ThemeData get darkTheme => _darkTheme;
  final ThemeData _darkTheme = ThemeData.dark().copyWith(
    // Esquema de colors principals
    colorScheme: ColorScheme.dark(
      primary: primaryDark,
      onPrimary: Colors.white,
      secondary: secondaryDark,
      onSecondary: Colors.white,
      // background: backgroundDark,
      // onBackground: Colors.white,
      surface: surfaceDark,
      onSurface: Colors.white,
      error: errorDark,
      onError: Colors.black,
    ),

    // Colors específics per a components
    scaffoldBackgroundColor: backgroundDark,
    appBarTheme: AppBarTheme(
      backgroundColor: surfaceDark,
      foregroundColor: Colors.white,
      elevation: 4,
    ),
    cardTheme: CardTheme(
      color: surfaceDark,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryDark,
        foregroundColor: Colors.white,
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryDark,
      foregroundColor: Colors.white,
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Color(0xFF2C2C2C), // Un gris fosc per als inputs
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.shade700),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.shade700),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: primaryDark, width: 2),
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryDark;
        }
        return Colors.grey.shade700;
      }),
      checkColor: WidgetStateProperty.all(Colors.white),
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: primaryDark,
      linearTrackColor: Colors.grey.shade800,
    ),
  );

  // MÈTODES PÚBLICS ------------------
  void changeThemeMode(ThemeMode mode) {
    Debug.debug(
      DebugLevel.debug_2,
      "Canviant mode de tema a: ${mode.toString()}",
    );
    _themeMode = mode;

    _isDarkMode =
        (mode == ThemeMode.system) ? Get.isDarkMode : (mode == ThemeMode.dark);

    Get.changeThemeMode(mode);

    // Actualitzar tots els GetBuilder's que escolten canvis sobre el tema.
    update();
  }

  void toggleTheme() {
    Debug.debug(
      DebugLevel.debug_2,
      "Alternant tema (actual: isDarkMode=$_isDarkMode)",
    );

    if (_themeMode == ThemeMode.system) {
      // Si estem en mode sistema, canviem a fosc o clar depenent de l'actual
      changeThemeMode(_isDarkMode ? ThemeMode.light : ThemeMode.dark);
    } else {
      // Si ja estem en mode manual, alternem entre fosc i clar
      changeThemeMode(
        _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark,
      );
    }
  }

  // Per detectar canvis en el tema del sistema
  void updateSystemTheme() {
    if (_themeMode == ThemeMode.system) {
      final brightness = PlatformDispatcher.instance.platformBrightness;
      final newIsDarkMode = brightness == Brightness.dark;

      if (_isDarkMode != newIsDarkMode) {
        Debug.debug(
          DebugLevel.debug_2,
          "Actualitzant tema del sistema (isDarkMode=$newIsDarkMode)",
        );
        _isDarkMode = newIsDarkMode;
        update([ctrlTag]);
      }
    }
  }
}
