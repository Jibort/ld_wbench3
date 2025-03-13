// Widget embolcall per a les targetes Card de l'aplicació.
// Created: 2025/03/06 dj.

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ld_wbench3/core/ld_view.dart';
import 'package:ld_wbench3/core/ld_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// WIDGET 'LdCardWidget' ==============
class LdCardWidget extends LdWidget<LdCardWidgetCtrl> {
  // 📝 ESTÀTICS -----------------------
  static const String className = "LdCardWidget";
  static const String widgetTag = "ldCardWidgetTag";

  // 🧩 MEMBRES --------------------------
  GetBuilder<LdCardWidgetCtrl>? _getBuilder;
  final Widget child;
  final double? elevation;
  final EdgeInsetsGeometry? padding;
  final ShapeBorder? shape;
  final Color? color;
  final Color? shadowColor;
  final BorderRadius? borderRadius;
  final VoidCallback? onTap;

  // 🛠️ CONSTRUCTORS ---------------------
  LdCardWidget({
    super.key,
    required LdViewCtrl viewCtrl,
    required this.child,
    this.elevation,
    this.padding,
    this.shape,
    this.color,
    this.shadowColor,
    this.borderRadius,
    this.onTap,
    String? pTag,
  }) : super(pViewCtrl: viewCtrl) {
    tag =
        pTag ??
        "${widgetTag}_${viewCtrl.tag}_${DateTime.now().millisecondsSinceEpoch}";
    typeName = className;
    ctrl = LdCardWidgetCtrl(
      pTag:
          pTag ??
          "${widgetTag}_${viewCtrl.tag}_${DateTime.now().millisecondsSinceEpoch}",
      pViewCtrl: viewCtrl,
      pFocusable: false,
    );
  }

  @override
  Widget build(BuildContext pCtx) {
    _getBuilder ??= GetBuilder<LdCardWidgetCtrl>(
      id: ctrl.tag,
      tag: ctrl.tag,
      init: ctrl,
      builder:
          (cardCtrl) => Card(
            elevation: elevation,
            shape:
                shape ??
                (borderRadius != null
                    ? RoundedRectangleBorder(borderRadius: borderRadius!)
                    : null),
            color: color,
            shadowColor: shadowColor,
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: onTap,
              borderRadius: borderRadius,
              child: Padding(
                padding: padding ?? EdgeInsets.all(16.0.w),
                child: child,
              ),
            ),
          ),
    );
    return _getBuilder!;
  }
}

// CTRL 'LdCardWidgetCtrl' ============
class LdCardWidgetCtrl extends LdWidgetCtrl {
  // 📝 ESTÀTICS -----------------------
  static const className = "LdCardWidgetCtrl";

  // CONSTRUCTOR ---------------------
  LdCardWidgetCtrl({
    required super.pTag,
    required super.pViewCtrl,
    required super.pFocusable,
  });

  // 'LdWdiget' -----------------------
  @override
  void rebuildFromScrath() {
    // No hi ha builders a anul·lar.
  }

  @override
  Widget buildWidget(BuildContext pCtx) {
    // Aquest mètode no s'utilitza directament perquè la construcció
    // es fa en el mètode build de LdCardWidget
    return Container();
  }
}
