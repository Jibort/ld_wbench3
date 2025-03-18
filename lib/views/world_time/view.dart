// Vista per mostrar l'hora mundial a diverses capitals.
// CreatedAt: 2025/03/15 ds.

import 'package:get/get.dart';
import 'package:ld_wbench3/core/ld_view.dart';
import 'package:ld_wbench3/tools/consts/ui.dart';
import 'package:ld_wbench3/tools/debug.dart';
import 'package:ld_wbench3/theme/ld_theme_ctrl.dart';
import 'package:ld_wbench3/views/world_time/controller.dart';
import 'package:ld_wbench3/views/world_time/state.dart';

export 'controller.dart';
export 'state.dart';

class WorldTimeView extends LdView<WorldTimeViewState, WorldTimeViewCtrl> {
  // 📝 ESTÀTICS -----------------------
  static String className = "WorldTimeView";
  static const routeName = "/world-time";

  // 🛠️ CONSTRUCTORS ------------------
  WorldTimeView({super.key, required String pTag})
    : super(pCtrl: Get.find<WorldTimeViewCtrl>(tag: pTag));
}

class WorldTimeViewBinding extends Bindings {
  // 'Bindinds' -----------------------
  @override
  void dependencies() {
    // Assegurem que el controlador de temes està registrat
    Debug.debug(DebugLevel.debug_0, "-> LdThemeCtrl.single;");
    LdThemeCtrl.single;

    // Crea l'estat de la vista
    Debug.debug(
      DebugLevel.debug_0,
      "-> WorldTimeViewState state = WorldTimeViewState(...)",
    );
    WorldTimeViewState state = WorldTimeViewState(
      pTitle: "Hora Mundial",
      pSubtitle: "Capitals del món",
    );

    // Crea el controlador de la vista
    Debug.debug(
      DebugLevel.debug_0,
      "-> WorldTimeViewCtrl ctrl = WorldTimeViewCtrl(...)",
    );
    WorldTimeViewCtrl ctrl = WorldTimeViewCtrl(
      pTag: WorldTimeView.className,
      pViewState: state,
    );

    // Afegeix el controlador a la cua de prioritat
    Debug.debug(DebugLevel.debug_0, "-> Get.parameters[parmElm] = ctrl.tag;");
    Get.parameters[parmViewTag] = ctrl.tag;
  }
}
