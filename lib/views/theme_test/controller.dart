// Controlador de la vista de test de temes.
// Created: 2025/03/06 dj. JIQ

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ld_wbench3/core/ld_view_ctrl.dart';
import 'package:ld_wbench3/theme/ld_theme_ctrl.dart';
import 'package:ld_wbench3/tools/consts/ui.dart';
import 'package:ld_wbench3/views/theme_test/state.dart';
import 'package:ld_wbench3/views/theme_test/theme_test_components.dart';
import 'package:ld_wbench3/widgets/ld_action_button_widget.dart';
import 'package:ld_wbench3/widgets/widget_key.dart';
import 'package:ld_wbench3/widgets/ld_scaffold_widget.dart';

class ThemeTestViewCtrl
    extends LdViewCtrl<ThemeTestViewCtrl, ThemeTestViewState> {
  // 📝 ESTÀTICS -----------------------
  static const className = "ThemeTestViewCtrl";

  // 🧩 MEMBRES --------------------------
  RxBool darkMode = Get.isDarkMode.obs;
  LdActionButtonWidget? btnDummy;

  // 🛠️ CONSTRUCTORS ------------------
  ThemeTestViewCtrl({required super.pTag, required super.pViewState}) {
    addWidgets([
      scaffoldIdx,
      pageBodyIdx,
      appBarIdx,
      appBarProgressIdx,
      btnDummyIdx,
    ]);
  }

  // 📥 GETTERS/SETTERS ----------------

  // Botons d'acció ------------------
  void toggleTheme() {
    btnDummy!.isEnabled = !btnDummy!.isEnabled;

    LdThemeCtrl.single.toggleTheme();
    notify(
      pTgts: [
        scaffoldIdx,
        appBarIdx,
        appBarProgressIdx,
        // LdThemeCtrl.single.tag,
        btnDummyIdx,
      ],
    );
  }

  void setLightTheme() {
    LdThemeCtrl.single.changeThemeMode(ThemeMode.light);
    notify();
  }

  void setDarkTheme() {
    LdThemeCtrl.single.changeThemeMode(ThemeMode.dark);
    notify();
  }

  void setSystemTheme() {
    LdThemeCtrl.single.changeThemeMode(ThemeMode.system);
    notify();
  }

  // Construcció de la vista
  @override
  Widget buildView(BuildContext pCtx) {
    return LdScaffoldWidget(
      pViewCtrl: this,
      pTitle: state.title,
      pSubTitle: state.subtitle,
      body:
          state.isLoading
              ? const Center(child: CircularProgressIndicator())
              : buildThemeTestContent(pCtx),
    );
  }

  Widget buildThemeTestContent(BuildContext context) {
    return ThemeTestComponents(viewCtrl: this);
  }
}
