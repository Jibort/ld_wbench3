// Classe base dels controladors de vistes de l'aplicació.
// CreatedAt: 2025/02/15 ds. JIQ

import 'package:flutter/widgets.dart';
import 'package:ld_wbench3/core/ld_ctrl.dart';
import 'package:ld_wbench3/core/ld_view_state.dart';
import 'package:ld_wbench3/tools/debug.dart';
import 'package:ld_wbench3/widgets/widget_key.dart';

abstract class LdViewCtrl<
  C extends LdViewCtrl<C, S>,
  S extends LdViewState<S, C>
>
    extends LdCtrl {
  // 📝 ESTÀTICS -----------------------
  static final String className = "LdViewCtrl";
  static int counter = 0;

  // 🧩 MEMBRES ------------------------
  final S _vState;
  final List<String> wgIds = <String>[];
  late String _scaffoldWIdx;
  late String _appBarWIdx;
  late String _barProgressWIdx;
  late String _pageBodyWIdx;

  // 🛠️ CONSTRUCTORS ------------------
  LdViewCtrl({required String pTag, required S pViewState})
    : _vState = pViewState,
      super(pTag: "${pTag}_$counter") {
    _vState.ctrl = this as C;
    _appBarWIdx = "${appBarIdx}_$counter";
    _barProgressWIdx = "$appBarProgressIdx}_$counter";
    _pageBodyWIdx = "${pageBodyIdx}_$counter";
    _scaffoldWIdx = "${scaffoldIdx}_${counter++}";

    if (state.isNew) {
      state.loadData();
    }
  }

  // 📥 GETTERS/SETTERS ----------------
  LdViewState get state => _vState;
  String get scaffoldWIdx => _scaffoldWIdx;
  String get appBarWIdx => _appBarWIdx;
  String get barProgressWIdx => _barProgressWIdx;
  String get pageBodyWIdx => _pageBodyWIdx;

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
