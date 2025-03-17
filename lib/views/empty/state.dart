// Estat de la vista 'EmptyView'.
// CreatedAt: 2025/03/11 dt. JIQ

import 'package:ld_wbench3/core/ld_view.dart';
import 'package:ld_wbench3/views/empty/view.dart';

class EmptyViewState extends LdViewState<EmptyViewState, EmptyViewCtrl> {
  // 📝 ESTÀTICS -----------------------
  static const className = "EmptyViewState";

  // 🛠️ CONSTRUCTORS ------------------
  EmptyViewState({required super.pTitle, super.pSubtitle});

  // 'LdViewState' --------------------
  @override
  Future<void> loadData() {
    return Future.value(null);
  }
}
