// Controlador de la vista de test de temes.
// Created: 2025/03/06 dj. JIQ

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ld_wbench3/core/ld_view_ctrl.dart';
import 'package:ld_wbench3/theme/ld_theme_ctrl.dart';
import 'package:ld_wbench3/views/theme_test/state.dart';
import 'package:ld_wbench3/views/theme_test/theme_test_components.dart';
import 'package:ld_wbench3/widgets/widget_key.dart';
import 'package:ld_wbench3/widgets/ld_scaffold_widget.dart';
import 'package:ld_wbench3/widgets/ld_app_bar_widget.dart';

class ThemeTestViewCtrl
    extends LdViewCtrl<ThemeTestViewCtrl, ThemeTestViewState> {
  // 📝 ESTÀTICS -----------------------
  static const className = "ThemeTestViewCtrl";

  // 🛠️ CONSTRUCTORS ------------------
  ThemeTestViewCtrl({required ThemeTestViewState pState, String? pTag})
    : super(pViewState: pState, pTag: pTag ?? "${className}_tag") {
    // Registrar widgets estructurals per a les notificacions
    addWidgets([scaffoldIdx, pageBodyIdx, appBarIdx, appBarProgressIdx]);
  }

  // GETTERS/SETTERS -----------------
  ThemeTestViewState get themeTestViewState =>
      super.state as ThemeTestViewState;

  // Botons d'acció ------------------
  void toggleTheme() {
    LdThemeCtrl.single.toggleTheme();
    notify(
      pTgts: [
        scaffoldIdx,
        appBarIdx,
        appBarProgressIdx,
        LdThemeCtrl.single.tag,
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
      appBar: LdAppBarWidget(
        viewCtrl: this,
        title: themeTestViewState.title,
        subtitle: themeTestViewState.subtitle,
        showProgress:
            themeTestViewState.isLoading || themeTestViewState.isLoadingAgain,
        actions: [
          IconButton(
            icon: Icon(Get.isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: toggleTheme,
            tooltip:
                Get.isDarkMode ? 'Canviar a tema clar' : 'Canviar a tema fosc',
          ),
        ],
      ),
      body:
          themeTestViewState.isLoading
              ? const Center(child: CircularProgressIndicator())
              : buildThemeTestContent(pCtx),
    );
  }

  Widget buildThemeTestContent(BuildContext context) {
    return ThemeTestComponents(viewCtrl: this);
  }
}
