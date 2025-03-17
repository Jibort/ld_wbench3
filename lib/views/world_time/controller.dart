// Controlador de la vista 'WorldTimeView'.
// CreatedAt: 2025/03/15 ds.

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:ld_wbench3/core/ld_view.dart';
import 'package:ld_wbench3/views/world_time/world_time.dart';
import 'package:ld_wbench3/services/services.dart';
import 'package:ld_wbench3/views/world_time/state.dart';
import 'package:ld_wbench3/widgets/ld_button_widget.dart';
import 'package:ld_wbench3/widgets/ld_card_widget.dart';
import 'package:ld_wbench3/widgets/separators.dart';
import 'package:ld_wbench3/widgets/widget_key.dart';
import 'package:ld_wbench3/widgets/ld_scaffold_widget.dart';
import 'package:ld_wbench3/widgets/ld_action_button_widget.dart';
import 'package:ld_wbench3/tools/debug.dart';

class WorldTimeViewCtrl
    extends LdViewCtrl<WorldTimeViewCtrl, WorldTimeViewState> {
  // 📝 ESTÀTICS -----------------------
  static const className = "WorldTimeViewCtrl";
  static const viewTag = "${className}_tag";
  static const btnRefreshIdx = "btnRefresh";

  // 🧩 MEMBRES ------------------------
  LdActionButtonWidget? btnRefresh;
  final _networkService = LdNetworkService.single;
  RxBool isLoading = false.obs;

  // Llista de zones horàries que mostrarem
  final List<String> capitalTimezones = [
    'Europe/London', // Londres
    'Europe/Paris', // París
    'America/New_York', // Nova York
    'Asia/Tokyo', // Tòquio
    'Australia/Sydney', // Sydney
  ];

  // 🛠️ CONSTRUCTORS ------------------
  WorldTimeViewCtrl({required super.pTag, required super.pViewState}) {
    addWidgets([
      scaffoldIdx,
      pageBodyIdx,
      appBarIdx,
      appBarProgressIdx,
      btnRefreshIdx,
    ]);
  }

  // 📥 GETTERS/SETTERS ----------------
  WorldTimeViewState get worldTimeViewState =>
      super.state as WorldTimeViewState;

  // ACCIONS --------------------------

  /// Carrega les dades d'hora mundial per a les capitals definides
  Future<void> loadWorldTimes() async {
    try {
      if (isLoading.value) return; // Evitem dobles càrregues

      isLoading.value = true;
      state.setPreparing();

      // Verificar que el servei està disponible
      final isServiceAvailable =
          await _networkService.isWorldTimeServiceAvailable();
      if (!isServiceAvailable) {
        Debug.error('El servei d\'hora mundial no està disponible', null);
        state.setException(
          'SERVICE_ERROR',
          'El servei d\'hora mundial no està disponible',
          Exception('El servei d\'hora mundial no està disponible'),
        );
        isLoading.value = false;
        return;
      }

      state.setLoading();

      // Obtenir les hores de les capitals
      final times = await _networkService.getTimeForMultipleZones(
        capitalTimezones,
      );

      // Actualitzar l'estat
      worldTimeViewState.worldTimes.value = times;
      worldTimeViewState.lastUpdated.value = DateTime.now();

      state.setLoaded(null);
    } catch (e) {
      Debug.error('Error carregant les hores mundials', e as Exception);
      state.setException(
        'LOAD_ERROR',
        'Error carregant les hores mundials: ${e.toString()}',
        e,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Actualitza les dades d'hora mundial
  void refreshWorldTimes() async {
    await loadWorldTimes();
    notify();
  }

  // 'LdViewCtrl' ---------------------
  @override
  Widget buildView(BuildContext pBCtx) {
    // Carregar les dades si és la primera vegada
    if (worldTimeViewState.worldTimes.isEmpty) {
      loadWorldTimes();
    }

    return LdScaffoldWidget(
      pViewCtrl: this,
      pTitle: state.title,
      pSubTitle: state.subtitle,
      actions: [
        btnRefresh = LdActionButtonWidget(
          pTag: btnRefreshIdx,
          pViewCtrl: this,
          pViewState: state,
          enabled: !isLoading.value,
          onPressed: refreshWorldTimes,
          iconData: Icons.refresh,
        ),
      ],
      body: Obx(() => buildWorldTimeBody(pBCtx)),
    );
  }

  Widget buildWorldTimeBody(BuildContext context) {
    if (isLoading.value) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            VertSep(16.0),
            Text('Carregant hores mundials...'),
          ],
        ),
      );
    }

    if (state.isError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, color: Colors.red, size: 64.h),
            VertSep(16.0),
            Text(
              state.errorMessage ?? 'Error desconegut',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.red),
            ),
            VertSep(24.0),
            LdButtonWidget(
              viewCtrl: this,
              text: 'Tornar a intentar',
              type: LdButtonType.elevated,
              onPressed: refreshWorldTimes,
              icon: Icon(Icons.refresh),
            ),
          ],
        ),
      );
    }

    if (worldTimeViewState.worldTimes.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('No hi ha dades disponibles.'),
            VertSep(16.0),
            LdButtonWidget(
              viewCtrl: this,
              text: 'Carregar dades',
              type: LdButtonType.elevated,
              onPressed: refreshWorldTimes,
              icon: Icon(Icons.refresh),
            ),
          ],
        ),
      );
    }

    // Mostrar les hores mundials
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Capçalera
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Text(
              'Hora actual a les principals capitals',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
          ),

          // Darrera actualització
          Padding(
            padding: EdgeInsets.only(bottom: 16.h),
            child: Row(
              children: [
                Icon(Icons.update, size: 16.h),
                HortSep(8.0),
                Text(
                  'Actualitzat: ${_getFormattedLastUpdateTime()}',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),

          // Targetes amb hores mundials
          ...worldTimeViewState.worldTimes.map(
            (time) => Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: _buildTimeCard(context, time),
            ),
          ),

          // Botó d'actualització
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: Center(
              child: LdButtonWidget.icon(
                viewCtrl: this,
                text: 'Actualitzar hores',
                type: LdButtonType.elevated,
                onPressed: refreshWorldTimes,
                iconData: Icons.refresh,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Construeix una targeta per cada hora mundial
  Widget _buildTimeCard(BuildContext context, WorldTime time) {
    final theme = Theme.of(context);

    return LdCardWidget(
      viewCtrl: this,
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Capçalera amb nom de la ciutat
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    time.displayName,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    time.abbreviation,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),

            VertSep(12.0),

            // Hora actual
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.access_time, size: 24.h),
                HortSep(8.0),
                Text(
                  time.formattedTime,
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),

            VertSep(8.0),

            // Data i informació de zona horària
            Row(
              children: [
                Icon(Icons.calendar_today, size: 16.h),
                HortSep(8.0),
                Text(time.formattedDate),
                HortSep(16.0),
                Icon(Icons.public, size: 16.h),
                HortSep(8.0),
                Text(time.formattedOffset),
              ],
            ),

            // Indicador DST si és aplicable
            if (time.isDST) ...[
              VertSep(8.0),
              Row(
                children: [
                  Icon(
                    Icons.wb_sunny_outlined,
                    size: 16.h,
                    color: Colors.amber,
                  ),
                  HortSep(8.0),
                  Text(
                    'Horari d\'estiu actiu',
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Colors.amber[700],
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  // Obté una representació formatada de l'hora de la darrera actualització
  String _getFormattedLastUpdateTime() {
    final lastUpdate = worldTimeViewState.lastUpdated.value;
    if (lastUpdate == null) {
      return 'Mai';
    }

    final now = DateTime.now();
    final diff = now.difference(lastUpdate);

    if (diff.inSeconds < 60) {
      return 'Fa uns segons';
    } else if (diff.inMinutes < 60) {
      return 'Fa ${diff.inMinutes} minuts';
    } else if (diff.inHours < 24) {
      return 'Fa ${diff.inHours} hores';
    } else {
      return 'Fa ${diff.inDays} dies';
    }
  }
}
