// Classe patró per a tots els controladors de vistes i widgets de l'aplicació.
// CreatedAt: 2025/02/12 dc. JIQ

import 'package:get/get.dart';
import 'package:get/get_instance/src/brand_map.dart';
import 'package:ld_wbench3/core/ld_id_mixin.dart';
import 'package:ld_wbench3/core/ld_view.dart';
import 'package:ld_wbench3/core/ld_widget_ctrl.dart';
import 'package:ld_wbench3/theme/ld_theme_ctrl.dart';
import 'package:ld_wbench3/tools/debug.dart';

abstract class LdCtrl extends GetxController with LdIdMixin {
  // 📝 ESTÀTICS -----------------------
  static const className = "LdCtrl";

  // 🛠️ CONSTRUCTORS -------------------
  LdCtrl({required String pTag}) {
    // Iniciem els membres de
    tag = pTag;
    typeName = className;

    // Utilitzar tag: tag per evitar conflictes
    switch (this) {
      case DummyViewCtrl():
        break;
      case LdWidgetCtrl():
        Get.put<LdWidgetCtrl>(this as LdWidgetCtrl, tag: tag, permanent: true);
        break;
      case LdViewCtrl():
        Get.put<LdViewCtrl>(this as LdViewCtrl, tag: tag, permanent: true);
        break;
      case LdThemeCtrl():
        break;
      // Get.put<LdThemeCtrl>(this as LdThemeCtrl, tag: tag, permanent: true);
      default:
        Get.put<LdCtrl>(this, tag: tag, permanent: true);
    }
  }

  // 🔄 'GetLifeCycleMixin' ------------
  @override
  void onClose() {
    // implementació arrel.
    Debug.debug(DebugLevel.debug_9, "Eliminant controlador '$tag' de GetX.");
    if (this is LdWidgetCtrl) {
      Get.delete<LdWidgetCtrl>(tag: tag, force: true);
    } else if (this is LdViewCtrl) {
      Get.delete<LdViewCtrl>(tag: tag, force: true);
    } else if (this is LdThemeCtrl) {
      Get.delete<LdThemeCtrl>(tag: tag, force: true);
    } else {
      Get.delete<LdCtrl>(tag: tag, force: true);
    }
  }

  // 📢 NOTIFICACIONS ------------------
  void notify({List<String>? pTgts}) {
    if (pTgts != null) {
      for (var wgId in pTgts) {
        update([wgId], true);
      }
    }
  }
} // abstract class LdCtrl
