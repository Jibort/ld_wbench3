// Widget embolcall per a les targetes Card de l'aplicació.
// Created: 2025/03/06 dj.

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ld_wbench3/core/ld_view.dart';
import 'package:ld_wbench3/core/ld_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// WIDGET 'LdCardWidget' ==============
class LdCardWidget extends LdWidget<LdCardWidgetState, LdCardWidgetCtrl> {
  // ESTÀTICS -------------------------
  static const String className = "LdCardWidget";
  static const String widgetTag = "ldCardWidgetTag";

  // MEMBRES --------------------------
  final Widget child;
  final double? elevation;
  final EdgeInsetsGeometry? padding;
  final ShapeBorder? shape;
  final Color? color;
  final Color? shadowColor;
  final BorderRadius? borderRadius;
  final VoidCallback? onTap;

  // CONSTRUCTOR ---------------------
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
    String? customTag,
  }) : super(
         pViewCtrl: viewCtrl,
         pState: LdCardWidgetState(
           pLabel: "Card Widget",
           pViewState: viewCtrl.state,
           pViewCtrl: viewCtrl,
         ),
       ) {
    ctrl = LdCardWidgetCtrl(
      pTag:
          customTag ??
          "${widgetTag}_${viewCtrl.tag}_${DateTime.now().millisecondsSinceEpoch}",
      pViewCtrl: viewCtrl,
      pState: state,
    );
  }

  @override
  Widget build(BuildContext pCtx) {
    return GetBuilder<LdCardWidgetCtrl>(
      id: ctrl.tag,
      tag: ctrl.tag,
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
  }
}

// STATE 'LdCardWidgetCtrl' ===========
class LdCardWidgetState extends LdWidgetState {
  // ESTÀTICS -------------------------
  static const className = "LdCardWidgetState";

  // CONSTRUCTOR ---------------------
  LdCardWidgetState({
    required super.pLabel,
    required super.pViewState,
    required super.pViewCtrl,
  });

  // IMPLEMENTACIÓ 'LdWidgetState'
  @override
  void loadData() {
    // No cal carregar dades específiques per aquest widget
  }
}

// CTRL 'LdCardWidgetCtrl' ============
class LdCardWidgetCtrl extends LdWidgetCtrl {
  // ESTÀTICS -------------------------
  static const className = "LdCardWidgetCtrl";

  // CONSTRUCTOR ---------------------
  LdCardWidgetCtrl({
    required super.pTag,
    required super.pViewCtrl,
    required LdCardWidgetState super.pState,
  });

  // GETTERS/SETTERS -----------------
  LdCardWidgetState get cardState => super.state as LdCardWidgetState;

  // Construir el widget
  @override
  Widget buildWidget(BuildContext pCtx) {
    // Aquest mètode no s'utilitza directament perquè la construcció
    // es fa en el mètode build de LdCardWidget
    return Container();
  }
}
