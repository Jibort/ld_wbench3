// Estat de la vista de test de temes.
// Created: 2025/03/06 dj.

import 'package:ld_wbench3/core/ld_view_state.dart';
import 'package:ld_wbench3/tools/debug.dart';
import 'package:ld_wbench3/tools/fi_fo.dart';
import 'package:ld_wbench3/views/theme_test/controller.dart';

class ThemeTestViewState extends LdViewState {
  // ESTÀTICS -------------------------
  static const className = "ThemeTestViewState";

  // MEMBRES --------------------------
  bool isThemeChanging = false;

  // CONSTRUCTOR ---------------------
  ThemeTestViewState()
    : super(
        pTitle: "Test de Temes",
        pSubtitle: "Prova les diferents opcions de tema",
      );

  // GETTERS/SETTERS -----------------
  ThemeTestViewCtrl get themeTestViewCtrl =>
      super.viewCtrl as ThemeTestViewCtrl;

  // Implementació de 'LdViewState'
  @override
  void loadData() {
    // Exemple de càrrega de dades fictícia
    setPreparing();

    // Pas 1: Simular una càrrega
    addFn((FiFo pQueue, List<dynamic> pArgs) async {
      // Simulem una càrrega ràpida
      await Future.delayed(const Duration(milliseconds: 300));
      return null;
    });

    // Pas 2: Finalitzar càrrega
    addFn((FiFo pQueue, List<dynamic> pArgs) async {
      setLoaded(null);
      Debug.debug(DebugLevel.debug_1, "ThemeTestViewState: Dades carregades");
      return null;
    });

    // Executar passos
    setLoading();
    runSteps();
  }
}
