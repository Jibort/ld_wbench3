// Abstracció d'un widget general per a l'aplicació.
// CreatedAt: 2025/03/06 dj. JIQ

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ld_wbench3/core/ld_app_ctrl.dart';
import 'package:ld_wbench3/tools/consts/devices.dart';

abstract class LdApp<C extends LdAppCtrl> extends GetWidget<C> {
  // 📝 ESTÀTICS -----------------------
  static const className = "LdApp";

  // 🧩 MEMBRES --------------------------
  final Size designSize;
  final C ctrl;

  // 🛠️ CONSTRUCTORS ---------------------
  const LdApp({
    super.key,
    this.designSize = iPhone8PlusSize,
    required this.ctrl,
  });

  // 'GetWidget' ----------------------
  @override
  Widget build(BuildContext pBCtx) {
    return ctrl.buildWidget(pBCtx);
  }
}
