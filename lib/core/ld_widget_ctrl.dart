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

  // 🛠️ CONSTRUCTORS ------------------
  LdWidgetCtrl({required super.pTag, required LdViewCtrl pViewCtrl})
    : _viewCtrl = pViewCtrl;

  // 📥 GETTERS/SETTERS ----------------
  LdViewCtrl get viewCtrl => _viewCtrl;

  // 🌥️ FUNCIONS ABSTRACTES -----------
  Widget buildWidget(BuildContext pBCtx);
}
