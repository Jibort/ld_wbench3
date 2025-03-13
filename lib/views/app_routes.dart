// Definició de les rutes per a les vistes de l'aplicació.
// CreatedAt: 2025/02/16 dg. GPT[JIQ]

// lib/views/app_routes.dart - Actualitzat per incloure la nova vista

import 'package:get/get.dart';
import 'package:ld_wbench3/tools/consts/ui.dart';
import 'package:ld_wbench3/views/empty/view.dart';
import 'package:ld_wbench3/views/theme_test/view.dart';

class AppRoutes {
  // 📝 ESTÀTICS -----------------------
  static const String initialRoute = EmptyView.routeName;

  // Llista de pàgines de l'aplicació
  static final List<GetPage> pages = [
    // EmptyView ----------------------
    GetPage(
      name: EmptyView.routeName,
      page: () {
        String tag = Get.parameters[parmElm] ?? "tag?";
        Get.parameters.remove(tag);
        return EmptyView(pTag: tag);
      },
      binding: EmptyViewBinding(),
    ),

    // ThemeTestView ------------------
    GetPage(
      name: ThemeTestView.routeName,
      page: () {
        String tag = Get.parameters[parmElm] ?? "tag?";
        Get.parameters.remove(tag);
        return ThemeTestView(pTag: tag);
      },
      binding: ThemeTestBinding(),
    ),
  ];
}
