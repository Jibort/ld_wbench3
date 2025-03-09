// Aplicació Sabina.
// CreatedAt: 2025/02/27 dj. JIQ

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ld_wbench3/core/ld_app.dart';
import 'package:ld_wbench3/ld_sabina_ctrl.dart';
import 'package:ld_wbench3/theme/ld_theme_ctrl.dart';
import 'package:ld_wbench3/trans/tr.dart';
import 'package:ld_wbench3/tools/consts/devices.dart';
import 'package:ld_wbench3/views/app_routes.dart';

class LdSabinaApp extends LdApp<LdSabinaCtrl> {
  // 📝 ESTÀTICS -----------------------
  static const className = "LdSabinaApp";

  // 🧩 MEMBRES --------------------------

  // 🛠️ CONSTRUCTORS ---------------------
  const LdSabinaApp({super.key, required super.ctrl});

  // 'StatelessWidget' ----------------
  @override
  Widget build(BuildContext pBCtx) {
    return ScreenUtilInit(
      designSize: iPhone8PlusSize,
      minTextAdapt: true,
      splitScreenMode: true,
      builder:
          (_, child) => Obx(
            () => GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'LdSabinaApp',
              themeMode: ctrl.themeMode.value,
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

  // @override
  Widget build_(BuildContext context) {
    return ScreenUtilInit(
      designSize: iPhone8PlusSize,
      minTextAdapt: true,
      splitScreenMode: true,
      builder:
          (_, child) => Obx(
            () => GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'LdSabinaApp',
              themeMode: ctrl.themeMode.value,
              theme: ThemeData.light(),
              darkTheme: ThemeData.dark(),
              locale: Get.deviceLocale, // Locale(_sCtrl.currentLocale.value),
              fallbackLocale: Locale('ca'),
              translations: Tr.single, // 🔹 Sistema de traducció personalitzat
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
              initialRoute:
                  AppRoutes
                      .initialRoute, // Utilitzem la variable de ruta inicial
              getPages: AppRoutes.pages,
            ),
          ),
    );
  }
}
