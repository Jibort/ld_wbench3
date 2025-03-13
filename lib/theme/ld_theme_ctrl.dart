// Controlador unificat per a la gestió de temes de l'aplicació.
// CreatedAt: 2025/03/07 dv.

import 'dart:ui';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:ld_wbench3/tools/debug.dart';
import 'package:ld_wbench3/core/ld_id_mixin.dart';

class LdThemeCtrl extends GetxController with LdIdMixin {
  // 📝 ESTÀTICS -----------------------
  static bool enabled = false;
  static late final LdThemeCtrl? _single;

  static LdThemeCtrl get single {
    if (!enabled) {
      enabled = true;
      _single = LdThemeCtrl();
    }
    return _single!;
  }

  static const className = "LdThemeCtrl";
  static const ctrlTag = "${className}_tag";

  // 🧩 MEMBRES ------------------------
  late ThemeMode _themeMode = ThemeMode.system;
  late bool _isDarkMode = false;

  // 🛠️ CONSTRUCTORS -------------------
  LdThemeCtrl() {
    tag = ctrlTag;
    typeName = className;
  } // : super(pTag: ctrlTag);

  void init() {
    // Detectar el mode actual del sistema
    // _isDarkMode = Get.isDarkMode;
    final platformBrightness = PlatformDispatcher.instance.platformBrightness;
    _isDarkMode = platformBrightness == Brightness.dark;

    // Inicialitzar _themeMode basat en la configuració del sistema
    // _themeMode = Get.isDarkMode ? ThemeMode.dark : ThemeMode.light;
    _themeMode = _isDarkMode ? ThemeMode.dark : ThemeMode.light;

    // Si l'aplicació està seguint el tema del sistema
    // if (Get.isPlatformDarkMode) {
    //   _themeMode = ThemeMode.system;
    // }
  }

  // 📥 GETTERS/SETTERS ----------------
  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _isDarkMode;

  // COLORS constants per a referència
  static const Color primaryLight = Color(
    0xFF4B70A5,
  ); // Blau mitjà de la barra de navegació
  static const Color primaryDark = Color(
    0xFF2D3B57,
  ); // Blau fosc de la capçalera

  static const Color secondaryLight = Color(
    0xFFE8C074,
  ); // To daurat/ataronjat del fons de la imatge
  static const Color secondaryDark = Color(0xFFD9A440); // To daurat més fosc

  static const Color backgroundLight = Color(0xFFF5F5F5); // Gris molt clar
  static const Color backgroundDark = Color(0xFF273042); // Blau molt fosc

  static const Color surfaceLight = Color(0xFFFFFFFF); // Blanc
  static const Color surfaceDark = Color(0xFF2F3A52); // Blau fosc grisós

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
      onSecondary: Colors.black87,
      surface: surfaceLight,
      onSurface: Colors.black87,
      error: errorLight,
      onError: Colors.white,
    ),

    // Colors específics per a components
    scaffoldBackgroundColor: backgroundLight,

    textTheme: TextTheme(
      // Específicament canviem l'estil del títol a blanc
      headlineLarge: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      // També afegim l'estil per a subtítols
      titleLarge: TextStyle(color: Colors.white),
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
        elevation: 6, // Més elevació en tema clar
        shadowColor: Colors.black.withAlpha((0.5 * 255.0).round()),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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

    appBarTheme: AppBarTheme(
      backgroundColor: primaryLight,
      foregroundColor: Colors.white,
      elevation: 4,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      // Assegurem que tots els textos de l'AppBar siguin blancs
      toolbarTextStyle: TextStyle(color: Colors.white),
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
      surface: surfaceDark,
      onSurface: Colors.white,
      error: errorDark,
      onError: Colors.black,
    ),

    // Colors específics per a components
    scaffoldBackgroundColor: Color(0xFF1E2433),

    textTheme: TextTheme(
      // Específicament canviem l'estil del títol a blanc
      headlineLarge: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      // També afegim l'estil per a subtítols
      titleLarge: TextStyle(color: Colors.white),
    ),

    cardTheme: CardTheme(
      color: surfaceDark,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromARGB(255, 89, 124, 172),
        foregroundColor: Colors.white,
        elevation: 8, // Elevació encara més alta en tema fosc
        shadowColor: Colors.black.withAlpha(
          (0.7 * 255.0).round(),
        ), // withOpacity(0.7), // Ombra més visible
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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

    appBarTheme: AppBarTheme(
      backgroundColor: primaryDark,
      foregroundColor: Colors.white, // Text blanc per la AppBar
      elevation: 4,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold, // Títol en negreta
      ),
      toolbarTextStyle: TextStyle(color: Colors.white),
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
        (mode == ThemeMode.system)
            ? PlatformDispatcher.instance.platformBrightness == Brightness.dark
            : (mode == ThemeMode.dark);

    // Canviar el tema i notificar a los oyentes
    Get.changeThemeMode(mode);
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

  // 📢 NOTIFICACIONS ------------------
  void notify({List<String>? pTgts}) {
    if (pTgts != null) {
      for (var wgId in pTgts) {
        update([wgId], true);
      }
    }
  }
}
