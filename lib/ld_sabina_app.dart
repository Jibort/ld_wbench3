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
      builder: (bCtx, child) {
        LdThemeCtrl();
        LdThemeCtrl tCtrl = LdThemeCtrl.single;
        ctrl.themeMode = LdThemeCtrl.single.themeMode.obs;
        Get.put(tCtrl, tag: tCtrl.tag, permanent: true);
        LdThemeCtrl.single.init();

        return Obx(
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
        );
      },
    );
  }
}
