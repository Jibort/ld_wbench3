// Entrada principal a l'aplicació Sabina amb test de temes.
// CreatedAt: 2025/03/06 dj.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ld_wbench3/ld_sabina_app.dart';
import 'package:ld_wbench3/ld_sabina_ctrl.dart';
import 'package:ld_wbench3/services/services.dart';

void main() async {
  // Assegurar-se que les dependències de Flutter estan inicialitzades
  WidgetsFlutterBinding.ensureInitialized();

  // Configurar l'orientació de l'aplicació
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Inicialitza els serveis globals.
  LdSecureStorageService.single;
  LdNetworkService.single;
  LdDatabaseService.single;
  LdAuthService.single;

  //  Prepara l'aplicació.
  final LdSabinaApp sabinaApp = LdSabinaApp(ctrl: LdSabinaCtrl());

  // Carregar preferències si és necessari
  await sabinaApp.ctrl.loadPreferences();

  // Inicialitzar els bindings per a la vista de proves
  // ThemeTestBinding().dependencies();

  // Iniciar l'aplicació utilitzant LdSabinaApplication
  runApp(sabinaApp);
}
