// Widget pels butons d'acció de l'AppBar.
// Created: 2025/03/13 dv. JIQ

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:ld_wbench3/core/ld_view_state.dart';
import 'package:ld_wbench3/core/ld_widget.dart';

class LdActionButtonWidget extends LdWidget<LdActionButtonWidgetCtrl> {
  // ESTÀTICS -------------------------
  static String className = "LdActionButtonWidget";

  // 🛠️ CONSTRUCTORS ---------------------
  LdActionButtonWidget({
    super.key,
    required String pTag,
    String label = "",
    required VoidCallback onPressed,
    IconData? iconData,
    Color? iconColor,
    Color? backgroundColor,
    bool enabled = true,
    bool focusable = false,
    double? iconSize,
    EdgeInsetsGeometry? padding,
    required super.pViewCtrl,
    required LdViewState pViewState,
  }) : super(pEnabled: enabled, pFocusable: focusable) {
    tag = pTag;
    typeName = className;

    ctrl = LdActionButtonWidgetCtrl(
      pTag: pTag,
      pViewCtrl: viewCtrl,
      label: label,
      onPressed: onPressed,
      pIconData: iconData,
      iconColor: iconColor,
      backgroundColor: backgroundColor,
      pEnabled: enabled,
      pFocusable: focusable,
      iconSize: iconSize,
      padding: padding,
    );
  }

  // METHODS --------------------------
  bool get isEnabled => ctrl.isEnabled;
  bool get isFocusable => ctrl.isFocusable;
  IconData? get iconData => ctrl.iconData;
  set iconData(IconData? value) => ctrl.iconData = value;

  void update([List<String>? tags]) {
    ctrl.update(tags);
  }

  set isEnabled(bool value) {
    ctrl.isEnabled = value;
    ctrl.notify();
  }

  void trigger() => ctrl.trigger();
}

class LdActionButtonWidgetCtrl extends LdWidgetCtrl {
  // 🧩 MEMBRES --------------------------
  final String label;
  final VoidCallback onPressed;
  Rx<IconData?> icon = Rx<IconData?>(null);
  final Color? iconColor;
  final Color? backgroundColor;
  final double? iconSize;
  final EdgeInsetsGeometry? padding;

  // 🛠️ CONSTRUCTORS ------------------
  LdActionButtonWidgetCtrl({
    required super.pTag,
    required super.pViewCtrl,
    required this.label,
    required this.onPressed,
    IconData? pIconData,
    this.iconColor,
    this.backgroundColor,
    super.pEnabled,
    super.pFocusable = false,
    this.iconSize,
    this.padding,
  }) {
    icon.value = pIconData;
  }

  // GETTERS/SETERS -------------------
  IconData? get iconData => icon.value;
  set iconData(IconData? pIconData) {
    icon.value = pIconData;
  }

  // PUBLIC METHODS -------------------
  void trigger() {
    if (isEnabled) {
      onPressed();
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  // 'LdWdiget' -----------------------
  @override
  void rebuildFromScrath() {
    // No hi ha builders a anul·lar.
  }

  @override
  Widget buildWidget(BuildContext pBCtrl) {
    // Accés segur al tema
    ThemeData? theme;
    Color defaultIconColor;

    try {
      // Utilitzem una solució més compatible per accedir al tema de forma segura
      bool isContextValid = false;

      try {
        // Comprovem si el context és vàlid
        final _ = pBCtrl.findRenderObject();
        isContextValid = true;
      } catch (e) {
        isContextValid = false;
      }

      if (isContextValid) {
        // Si el context és vàlid, utilitzem Theme.of de forma segura
        try {
          theme = Theme.of(pBCtrl);
          defaultIconColor = iconColor ?? theme.colorScheme.onPrimary;
        } catch (e) {
          // Si falla l'accés al tema, utilitzem un valor per defecte
          defaultIconColor = iconColor ?? Colors.white;
        }
      } else {
        // Si el context no és vàlid, utilitzem un valor per defecte
        defaultIconColor = iconColor ?? Colors.white;
      }
    } catch (e) {
      // Si hi ha qualsevol altre error, utilitzem valors per defecte
      defaultIconColor = iconColor ?? Colors.white;
    }

    // Colors per defecte que coincideixen amb l'AppBar
    final Color defaultBgColor = backgroundColor ?? Colors.transparent;

    // Si tenim una icona, utilitzem un IconButton estilitzat
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(4.0),
      clipBehavior: Clip.antiAlias,
      child: Container(
        decoration: BoxDecoration(
          color: isEnabled ? defaultBgColor : Colors.transparent,
          borderRadius: BorderRadius.circular(4.0),
          border: Border.all(
            color:
                isEnabled
                    ? defaultIconColor.withAlpha(80) // Més visible
                    : Colors.grey.withAlpha(60),
            width: 1.5, // Una mica més gruixuda
          ),
        ),
        child: InkWell(
          onTap: isEnabled ? onPressed : null,
          canRequestFocus: isFocusable,
          splashColor: defaultIconColor.withAlpha(30),
          highlightColor: defaultIconColor.withAlpha(20),
          child: Padding(
            padding: padding ?? const EdgeInsets.all(4.0), // Menys marge
            child: Icon(
              icon.value ?? Icons.question_mark,
              color: isEnabled ? defaultIconColor : Colors.grey,
              size: iconSize ?? 20.0.h,
            ),
          ),
        ),
      ),
    );
  }
}
