// Classe base dels controladors de vistes de l'aplicació.
// CreatedAt: 2025/02/15 ds. JIQ

import 'package:flutter/widgets.dart';
import 'package:ld_wbench3/core/ld_ctrl.dart';
import 'package:ld_wbench3/core/ld_view_state.dart';
import 'package:ld_wbench3/tools/debug.dart';

abstract class LdViewCtrl<
  C extends LdViewCtrl<C, S>,
  S extends LdViewState<S, C>
>
    extends LdCtrl {
  // 📝 ESTÀTICS -----------------------
  static final String className = "LdViewCtrl";

  // 🧩 MEMBRES ------------------------
  final S _vState;
  final List<String> wgIds = <String>[];

  // 🛠️ CONSTRUCTORS ------------------
  LdViewCtrl({required super.pTag, required S pViewState})
    : _vState = pViewState {
    _vState.ctrl = this as C;
    if (state.isNew) {
      state.loadData();
    }
  }

  // 📥 GETTERS/SETTERS ----------------
  LdViewState get state => _vState;

  // GESTIÓ DE WIDGETS ----------------
  void addWidgets(List<String> pWgIds) {
    for (var wgId in pWgIds) {
      if (!wgIds.contains(wgId)) {
        wgIds.add(wgId);
      } else {
        Debug.error(
          "${runtimeType.toString()}.addWidgets(): widget ja existeix: '$wgId'",
          null,
        );
      }
    }
  }

  void resetState() {
    state.reset();
  }

  // 🌥️ FUNCIONS ABSTRACTES -----------
  Widget buildView(BuildContext pCtx);

  // Actualització de controladors de widgets.
  @override
  void notify({List<String>? pTgts}) =>
      super.notify(pTgts: pTgts ?? [...wgIds, tag]);
}
