// Definició de les rutes per a les vistes de l'aplicació.
// CreatedAt: 2025/02/16 dg. GPT[JIQ]

// lib/views/app_routes.dart - Actualitzat per incloure la nova vista

import 'package:get/get.dart';
import 'package:ld_wbench3/views/theme_test/view.dart';

class AppRoutes {
  // Ruta inicial
  static const String initialRoute = ThemeTestView.routeName;

  // Llista de pàgines de l'aplicació
  static final List<GetPage> pages = [
    GetPage(
      name: ThemeTestView.routeName,
      page: () {
        String tag = Get.parameters[parmElm] ?? "tag?";
        ThemeTestViewCtrl ctrl = Get.find<ThemeTestViewCtrl>(tag: tag);
        Get.parameters.remove(tag);
        return ThemeTestView(pCtrl: ctrl);
      },
      binding: ThemeTestBinding(),
    ),
  ];
}
