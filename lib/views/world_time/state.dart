// Estat de la vista 'WorldTimeView'.
// CreatedAt: 2025/03/15 ds.

import 'package:get/get.dart';
import 'package:ld_wbench3/core/ld_view.dart';
import 'package:ld_wbench3/services/ld_network_service.dart';
import 'package:ld_wbench3/tools/debug.dart';
import 'package:ld_wbench3/tools/fi_fo.dart';
import 'package:ld_wbench3/views/world_time/world_time.dart';
import 'package:ld_wbench3/views/world_time/controller.dart';

class WorldTimeViewState
    extends LdViewState<WorldTimeViewState, WorldTimeViewCtrl> {
  // 📝 ESTÀTICS -----------------------
  static const className = "WorldTimeViewState";

  // 🧩 MEMBRES --------------------------
  // Dades d'hores mundials
  final RxList<WorldTime?> worldTimes = <WorldTime?>[].obs;
  final _networkService = LdNetworkService.single;
  final Map<String, WorldTime?> _times = {};

  // Llista de zones horàries que mostrarem
  final List<String> capitalTimezones = [
    'Europe/London', // Londres
    'Europe/Paris', // París
    'America/New_York', // Nova York
    'Asia/Tokyo', // Tòquio
    'Australia/Sydney', // Sydney
  ];

  // Hora de la darrera actualització
  final Rx<DateTime?> lastUpdated = Rx<DateTime?>(null);

  // 🛠️ CONSTRUCTORS ------------------
  WorldTimeViewState({required super.pTitle, super.pSubtitle});

  // 📥 GETTERS/SETTERS ----------------
  WorldTime? getCapitalTime(String pCapital) => _times[pCapital];

  // 'LdViewState' --------------------
  @override
  Future<void> loadData() async {
    Exception? exc;
    setPreparing();

    worldTimes.clear();
    for (String capital in capitalTimezones) {
      stStep(FiFo<dynamic> pQueue, List<dynamic> pArgs) async {
        try {
          WorldTime? wt = await _networkService.getTimeForZone(capital);
          worldTimes.value.add(wt);
          lastUpdated.value = DateTime.now();
        } on Exception catch (pExc) {
          String excMsg =
              'Error carregant l\'hora de "$capital" (${pExc.toString()}).';
          Debug.error(excMsg, pExc);
          setException('LOAD_ERROR', excMsg, pExc);
          exc = pExc;
        }
        return exc;
      }

      sneakFn(stStep);
    }

    setLoading();
    await runSteps(ctrl)
        .timeout(
          Duration(seconds: 15),
          onTimeout: () {
            Debug.error(
              "Timeout a runSteps()! S'està bloquejant la càrrega?",
              null,
            );
            return ([], Exception("Timeout a la càrrega de dades"));
          },
        )
        .then((pLExc) {
          setLoaded(pLExc.$2);
        });
  }

  // Netejar les dades existents
  void clearData() {
    reset();
  }

  // Restaura l'estat i força una recàrrega
  @override
  void reset() {
    super.reset();
    _times.clear();
    lastUpdated.value = null;
  }
}
