// Estat de la vista 'WorldTimeView'.
// CreatedAt: 2025/03/15 ds.

import 'package:get/get.dart';
import 'package:ld_wbench3/core/ld_view.dart';
import 'package:ld_wbench3/views/world_time/world_time.dart';
import 'package:ld_wbench3/views/world_time/controller.dart';

class WorldTimeViewState
    extends LdViewState<WorldTimeViewState, WorldTimeViewCtrl> {
  // 📝 ESTÀTICS -----------------------
  static const className = "WorldTimeViewState";

  // 🧩 MEMBRES --------------------------
  // Dades d'hores mundials
  final RxList<WorldTime> worldTimes = <WorldTime>[].obs;

  // Hora de la darrera actualització
  final Rx<DateTime?> lastUpdated = Rx<DateTime?>(null);

  // 🛠️ CONSTRUCTORS ------------------
  WorldTimeViewState({required super.pTitle, super.pSubtitle});

  // 'LdViewState' --------------------
  @override
  void loadData() {
    // Aquesta funció es crida automàticament quan es crea l'estat
    // Però la càrrega real es farà des del controlador
  }

  // Netejar les dades existents
  void clearData() {
    worldTimes.clear();
    lastUpdated.value = null;
  }

  // Restaura l'estat i força una recàrrega
  @override
  void reset() {
    super.reset();
    clearData();
  }
}
