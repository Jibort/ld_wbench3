// Classe controladora de Widgets.
// CreatedAt: 2025/02/21 dv. JIQ

import 'package:flutter/widgets.dart';
import 'package:ld_wbench3/core/ld_ctrl.dart';
import 'package:ld_wbench3/core/ld_view.dart';

abstract class LdWidgetCtrl extends LdCtrl {
  // 📝 ESTÀTICS -----------------------
  static const className = "LdWidgetCtrl";

  // 🧩 MEMBRES ------------------------
  // Vista on es renderitza el widget.
  final LdViewCtrl _viewCtrl;
  // Cert només si el widget està disponible.
  bool _enabled = true;

  // 🛠️ CONSTRUCTORS ------------------
  LdWidgetCtrl({
    required super.pTag,
    required LdViewCtrl pViewCtrl,
    bool pEnabled = true,
  }) : _viewCtrl = pViewCtrl {
    isEnabled = pEnabled;
  }

  // 📥 GETTERS/SETTERS ----------------
  LdViewCtrl get viewCtrl => _viewCtrl;
  bool get isEnabled => _enabled;
  set isEnabled(bool pEnabled) {
    _enabled = pEnabled;
    update([tag]);
  }

  // 🌥️ FUNCIONS ABSTRACTES -----------
  void rebuildFromScrath();
  Widget buildWidget(BuildContext pBCtx);
}
