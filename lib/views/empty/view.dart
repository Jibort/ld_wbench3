// Vista buïda amb LdAppBar i LdActionButtons.
// CreatedAt: 2025/03/11 dt. JIQ

// ignore_for_file: deprecated_member_use

import 'package:get/get.dart';
import 'package:ld_wbench3/core/ld_view.dart';
import 'package:ld_wbench3/theme/ld_theme_ctrl.dart';
import 'package:ld_wbench3/tools/consts/ui.dart';
import 'package:ld_wbench3/tools/debug.dart';
import 'package:ld_wbench3/views/empty/controller.dart';
import 'package:ld_wbench3/views/empty/state.dart';

export 'controller.dart';
export 'state.dart';

class EmptyView extends LdView<EmptyViewState, EmptyViewCtrl> {
  // 📝 ESTÀTICS -----------------------
  static String className = "EmptyView";
  static String viewTag = "${className}_tag";
  static const routeName = "/empty";

  // 🛠️ CONSTRUCTORS ------------------
  EmptyView({super.key, required String pTag})
    : super(pCtrl: Get.find<EmptyViewCtrl>(tag: pTag));
}

class EmptyViewBinding extends Bindings {
  // 'Bindinds' -----------------------
  @override
  void dependencies() {
    // Asegurem que el controlador de temes està registrat.
    Debug.debug(DebugLevel.debug_0, "-> LdThemeCtrl.single;");
    LdThemeCtrl.single;

    // Si és necessari recupera arguments per a la creació de l'estat.
    // ...

    // Crea l'estat de la vista.
    Debug.debug(
      DebugLevel.debug_0,
      "-> EmptyViewState state = EmptyViewState(...)",
    );
    EmptyViewState state = EmptyViewState(
      pTitle: "Empty View Title",
      pSubtitle: "La més simple de totes",
    );

    // Crea el controlador de la vista.
    Debug.debug(
      DebugLevel.debug_0,
      "-> EmptyViewCtrl ctrl = EmptyViewCtrl(...)",
    );
    EmptyViewCtrl ctrl = EmptyViewCtrl(
      pTag: EmptyView.viewTag,
      pViewState: state,
    );

    // Afegeix el controlador a la cua de prioritat
    Debug.debug(DebugLevel.debug_0, "-> Get.parameters[parmElm] = ctrl.tag;");
    Get.parameters[parmElm] = ctrl.tag;
  }
}
