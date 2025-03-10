// Vista per comprovar el funcionament dels temes de l'aplicació.
// Created: 2025/03/06 dj. CLA[JIQ]

// ignore_for_file: deprecated_member_use

import 'package:get/get.dart';
import 'package:ld_wbench3/core/ld_view.dart';
import 'package:ld_wbench3/theme/ld_theme_ctrl.dart';
import 'package:ld_wbench3/views/theme_test/controller.dart';
import 'package:ld_wbench3/views/theme_test/state.dart';

export 'controller.dart';
export 'state.dart';

const String parmElm = "parmElm";

class ThemeTestView extends LdView<ThemeTestViewState, ThemeTestViewCtrl> {
  // 📝 ESTÀTICS -----------------------
  static const className = "ThemeTestView";
  static const routeName = "/theme-test";

  // CONSTRUCTORS ---------------------
  ThemeTestView({super.key, required String pTag})
    : super(pCtrl: Get.find<ThemeTestViewCtrl>(tag: pTag));
}

class ThemeTestBinding extends Bindings {
  @override
  void dependencies() {
    // Asegurem que el controlador de temes està registrat.
    LdThemeCtrl.single;
    // Si és necessari recupera arguments per a la creació de l'estat.
    // ...
    // Crea l'estat de la vista.
    ThemeTestViewState state = ThemeTestViewState();
    // Crea el controlador de la vista.
    ThemeTestViewCtrl ctrl = ThemeTestViewCtrl(pState: state);
    // Get.put<ThemeTestViewCtrl>(ctrl, tag: ctrl.tag, permanent: true);
    // Afegeix el controlador a la cua de prioritat
    Get.parameters[parmElm] = ctrl.tag;
  }
}
