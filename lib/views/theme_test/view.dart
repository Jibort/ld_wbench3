// Vista per comprovar el funcionament dels temes de l'aplicació.
// Created: 2025/03/06 dj. CLA[JIQ]

// ignore_for_file: deprecated_member_use

import 'package:get/get.dart';
import 'package:ld_wbench3/core/ld_view.dart';
import 'package:ld_wbench3/theme/ld_theme_controller.dart';
import 'package:ld_wbench3/views/theme_test/controller.dart';
import 'package:ld_wbench3/views/theme_test/state.dart';

class ThemeTestView extends LdView<ThemeTestViewState, ThemeTestViewCtrl> {
  // ESTÀTICS -------------------------
  static const className = "ThemeTestView";
  static const routeName = "/theme-test";

  // CONSTRUCTORS ---------------------
  ThemeTestView({super.key, required super.pCtrl});
}

class ThemeTestBinding extends Bindings {
  @override
  void dependencies() {
    // Registrar el controlador de temes
    Get.put<LdThemeController>(
      LdThemeController(),
      tag: LdThemeController.ctrlTag,
      permanent: true,
    );
  }
}
