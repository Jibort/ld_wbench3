// Controlador d'una aplicació LdApp.
// CreatedAt: 2025/03/06 dj. JIQ

import 'package:get/get.dart';
import 'package:flutter/widgets.dart';

// CTRL 'LdAppCtrl' -------------------
abstract class LdAppCtrl extends FullLifeCycleController {
  // 📝 ESTÀTICS -----------------------
  static final String className = "LdAppCtrl";

  // 🧩 MEMBRES -----------------------

  // 🛠️ CONSTRUCTORS ------------------
  LdAppCtrl();

  // FUNCIONS ABSTRACTES --------------
  Widget buildWidget(BuildContext pBCtx);

  //
}
