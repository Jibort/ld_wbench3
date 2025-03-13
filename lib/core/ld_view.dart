// Classe genèrica per a totes les vistes de l'aplicació.
// CreateAt: 2025/02/17 ds. JIQ

import 'package:get/get.dart';
import 'package:flutter/widgets.dart';
import 'package:ld_wbench3/core/ld_view_ctrl.dart';
import 'package:ld_wbench3/core/ld_view_state.dart';

export 'package:ld_wbench3/core/ld_view_ctrl.dart';
export 'package:ld_wbench3/core/ld_view_state.dart';

// VISTA BASE 'LdView' ================
abstract class LdView<S extends LdViewState<S, C>, C extends LdViewCtrl<C, S>>
    extends GetView<C> {
  // 📝 ESTÀTICS -----------------------
  static const className = "LdView";

  // 🧩 MEMBRES ------------------------
  // Builder base per a l'actualització per canvis en el tema.
  GetBuilder<C>? _getBuilder;
  final S _state;
  final C _ctrl;

  // 🛠️ CONSTRUCTORS -------------------
  LdView({super.key, required C pCtrl})
    : _ctrl = pCtrl,
      _state = pCtrl.state as S;

  // 📥 GETTERS/SETTERS ----------------
  S get state => _state;
  C get ctrl => _ctrl;

  // 🛠️ CONSTRUCCIÓ DE LA VISTA -------
  @override
  @mustCallSuper
  Widget build(BuildContext pCtx) {
    _getBuilder ??= GetBuilder<C>(
      id: ctrl.tag,
      tag: ctrl.tag,
      init: ctrl,
      builder: (vCtrl) => _ctrl.buildView(pCtx),
    );
    return _getBuilder!;
  }
}
