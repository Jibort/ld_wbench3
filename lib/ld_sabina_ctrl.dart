// Controlador principal de l'aplicació Sabina.
// CreatedAt: 2025/02/13 dj. JIQ

// Controlador principal de l'aplicació Sabina.
// CreatedAt: 2025/02/13 dj. JIQ

// ignore_for_file: avoid_renaming_method_parameters

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ld_wbench3/trans/tr.dart';
import 'package:ld_wbench3/tools/debug.dart';
import 'package:ld_wbench3/views/app_routes.dart';
import 'package:ld_wbench3/core/ld_app_ctrl.dart';
import 'package:ld_wbench3/theme/ld_theme_ctrl.dart';
import 'package:ld_wbench3/tools/consts/devices.dart';

class LdSabinaCtrl extends LdAppCtrl {
  // 📝 ESTÀTICS -----------------------
  static const className = "LdSabinaCtrl";

  // 🧩 MEMBRES --------------------------
  final LdThemeCtrl _theme;
  late Rx<ThemeMode> themeMode;

  // CONSTRUCTOR ----------------------
  LdSabinaCtrl({LdThemeCtrl? pTheme}) : _theme = pTheme ?? LdThemeCtrl() {
    Get.put(LdThemeCtrl(), permanent: true);
    themeMode = _theme.themeMode.obs;
  }

  // 'LdAppCtrl' ----------------------
  @override
  Widget buildWidget(BuildContext pBCtx) {
    return ScreenUtilInit(
      designSize: iPhone8PlusSize,
      minTextAdapt: true,
      splitScreenMode: true,
      builder:
          (_, child) => Obx(
            () => GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'LdSabinaApp',
              themeMode: themeMode.value,
              theme: LdThemeCtrl.single.lightTheme,
              darkTheme: LdThemeCtrl.single.darkTheme,
              locale: Get.deviceLocale,
              fallbackLocale: Locale('ca'),
              translations: Tr.single,
              supportedLocales: const [
                Locale('ca'),
                Locale('es'),
                Locale('en'),
                Locale('fr'),
                Locale('pt'),
              ],
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              initialRoute: AppRoutes.initialRoute,
              getPages: AppRoutes.pages,
            ),
          ),
    );
  }

  // 🧩 MÈTODES ------------------------
  void toggleTheme() {
    themeMode.value = (Get.isDarkMode) ? ThemeMode.light : ThemeMode.dark;
    Get.changeThemeMode(themeMode.value);
  }

  void setLightTheme() {
    themeMode.value = ThemeMode.light;
    Get.changeThemeMode(ThemeMode.light);
  }

  void setDarkTheme() {
    themeMode.value = ThemeMode.dark;
    Get.changeThemeMode(ThemeMode.dark);
  }

  // 🔹 GESTIÓ DE L'IDIOMA --------------
  RxString currentLocale = 'ca'.obs;

  void changeLanguage(String langCode) {
    currentLocale.value = langCode;
    Get.updateLocale(Locale(langCode));
  }

  // 🔹 ESTAT DE CONNEXIÓ ----------------
  // RxBool isOnline = false.obs;

  // void updateNetworkStatus(bool status) {
  //   isOnline.value = status;
  // }

  // Carrega les preferències ---------
  Future<void> loadPreferences() async {
    // Implementació futura: carregar configuracions de SharedPreferences o una BD
  }

  // 'WidgetsBindingObserver' ------------
  // Quan es produeix un canvi en l'estat del cicle de vida de l'aplicacio.
  @mustCallSuper
  @override
  void didChangeAppLifecycleState(AppLifecycleState pState) {
    switch (pState) {
      case AppLifecycleState.resumed:
        onResumed();
        break;
      case AppLifecycleState.inactive:
        onInactive();
        break;
      case AppLifecycleState.paused:
        onPaused();
        break;
      case AppLifecycleState.detached:
        onDetached();
        break;
      case AppLifecycleState.hidden:
        onHidden();
        break;
    }
  }

  // Quan l'aplicació torna a primer pla
  void onResumed() {
    Debug.info(
      "[onResumed.${runtimeType.toString()}]: L'aplicació ha tornat a primer pla.",
    );
  }

  // Quan l'aplicació és minimitzada o passa a segon pla
  void onPaused() {
    Debug.info(
      "[onPaused.${runtimeType.toString()}]: L'aplicació ha estat minimitzada.",
    );
  }

  // Quan l'aplicació està en estat inactiu (com per exemple, en una trucada)
  void onInactive() {
    Debug.info(
      "[onInactive.${runtimeType.toString()}]: L'aplicació està en estat inactiu.",
    );
  }

  // Quan l'aplicació és tancada pel sistema operatiu
  void onDetached() {
    Get.delete(tag: className);
    Debug.info(
      "[onDetached.${runtimeType.toString()}]: L'aplicació ha estat completament tancada.",
    );
  }

  // Quan l'aplicació es ocultada.
  void onHidden() {
    Debug.info(
      "[onHidden.${runtimeType.toString()}]: L'aplicació ha estat ocultada.",
    );
  }
}
