// Controlador de la vista de test de temes.
// Created: 2025/03/06 dj.

import 'package:flutter/material.dart';
import 'package:ld_wbench3/core/ld_view_ctrl.dart';
import 'package:ld_wbench3/theme/ld_theme_controller.dart';
import 'package:ld_wbench3/views/theme_test/state.dart';
import 'package:ld_wbench3/views/theme_test/theme_test_components.dart';
import 'package:ld_wbench3/widgets/widget_key.dart';
import 'package:ld_wbench3/widgets/ld_scaffold_widget.dart';
import 'package:ld_wbench3/widgets/ld_app_bar_widget.dart';
import 'package:get/get.dart';

class ThemeTestViewCtrl extends LdViewCtrl {
  // ESTÀTICS -------------------------
  static const className = "ThemeTestViewCtrl";
  static const ctrlTag = "themeTestCtrl";

  // CONSTRUCTOR ---------------------
  ThemeTestViewCtrl({required ThemeTestViewState pState, String? pTag})
    : super(pState: pState, pTag: pTag ?? ctrlTag) {
    // Registrar widgets per notificacions
    addWidgets([
      WidgetKey.scaffold.idx,
      WidgetKey.pageBody.idx,
      WidgetKey.appBar.idx,
    ]);
  }

  // GETTERS/SETTERS -----------------
  ThemeTestViewState get themeTestViewState =>
      super.state as ThemeTestViewState;

  // Botons d'acció ------------------
  void toggleTheme() {
    LdThemeController.inst.toggleTheme();
    notify();
  }

  void setLightTheme() {
    LdThemeController.inst.changeThemeMode(ThemeMode.light);
    notify();
  }

  void setDarkTheme() {
    LdThemeController.inst.changeThemeMode(ThemeMode.dark);
    notify();
  }

  void setSystemTheme() {
    LdThemeController.inst.changeThemeMode(ThemeMode.system);
    notify();
  }

  // Construcció de la vista
  @override
  Widget buildView(BuildContext pCtx) {
    return LdScaffoldWidget(
      viewCtrl: this,
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
