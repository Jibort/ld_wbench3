// Classe embolcall per a tots els widgets de l'aplicació.
// CreatedAt: 2025/02/12 dc. JIQ

// ignore_for_file: unnecessary_getters_setters

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ld_wbench3/core/ld_id_mixin.dart';
import 'package:ld_wbench3/core/ld_view_ctrl.dart';
import 'package:ld_wbench3/core/ld_view_state.dart';
import 'package:ld_wbench3/core/ld_widget_ctrl.dart';
import 'package:ld_wbench3/theme/ld_theme_ctrl.dart';

export 'package:ld_wbench3/core/ld_widget_ctrl.dart';

abstract class LdWidget<C extends LdWidgetCtrl> extends GetWidget<C>
    with LdIdMixin {
  // 🧩 MEMBRES ------------------------
  // Builder base per a l'actualització per canvis en el tema.
  GetBuilder<LdThemeCtrl>? _getBuilder;
  // Cotrolador de la vista on es renderitza el Widget.
  final LdViewCtrl _viewCtrl;
  late final C _ctrl; // Controlador del Widget.

  // CONSTRUCTOR ------------------
  LdWidget({super.key, required LdViewCtrl pViewCtrl}) : _viewCtrl = pViewCtrl;

  // 📥 GETTERS/SETTERS ------------------
  LdViewCtrl get viewCtrl => _viewCtrl;
  LdViewState get viewState => _viewCtrl.state;

  C get ctrl => _ctrl;
  set ctrl(C pCtrl) => _ctrl = pCtrl;

  // CONSTRUCCIÓ DE LA VISTA ----------
  @override
  Widget build(BuildContext pBCtx) {
    _getBuilder ??= GetBuilder<LdThemeCtrl>(
      id: LdThemeCtrl.ctrlTag,
      tag: LdThemeCtrl.ctrlTag,
      builder: (pTCtrl) {
        return _ctrl.buildWidget(pBCtx);
      },
    );
    return _getBuilder!;
  }
}
