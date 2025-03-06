// Widget per a seccions de demostració de tema.
// Created: 2025/03/06 dj.

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ld_wbench3/core/ld_widget.dart';
import 'package:ld_wbench3/core/ld_view_ctrl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// WIDGET 'LdThemeSectionWidget' ======
class LdThemeSectionWidget
    extends LdWidget<LdThemeSectionWidgetState, LdThemeSectionWidgetCtrl> {
  // ESTÀTICS -------------------------
  static const String className = "LdThemeSectionWidget";
  static const String widgetTag = "ldThemeSectionWidgetTag";

  // MEMBRES --------------------------
  final String title;
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  // CONSTRUCTOR ---------------------
  LdThemeSectionWidget({
    super.key,
    required LdViewCtrl viewCtrl,
    required this.title,
    required this.child,
    this.padding,
    this.margin,
    String? customTag,
  }) : super(
         pViewCtrl: viewCtrl,
         pState: LdThemeSectionWidgetState(
           pLabel: title,
           pViewState: viewCtrl.state,
           pViewCtrl: viewCtrl,
         ),
       ) {
    ctrl = LdThemeSectionWidgetCtrl(
      pTag:
          customTag ??
          "${widgetTag}_${viewCtrl.tag}_${DateTime.now().millisecondsSinceEpoch}",
      pViewCtrl: viewCtrl,
      pState: state,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LdThemeSectionWidgetCtrl>(
      id: ctrl.tag,
      tag: ctrl.tag,
      builder:
          (sectionCtrl) => Container(
            margin: margin ?? EdgeInsets.only(bottom: 24.0.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 12.0.h),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 18.0.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(padding: padding ?? EdgeInsets.zero, child: child),
              ],
            ),
          ),
    );
  }
}

class LdThemeSectionWidgetState extends LdWidgetState {
  // ESTÀTICS -------------------------
  static const className = "LdThemeSectionWidgetState";

  // CONSTRUCTOR ---------------------
  LdThemeSectionWidgetState({
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

class LdThemeSectionWidgetCtrl extends LdWidgetCtrl {
  // ESTÀTICS -------------------------
  static const className = "LdThemeSectionWidgetCtrl";

  // CONSTRUCTOR ---------------------
  LdThemeSectionWidgetCtrl({
    required super.pTag,
    required super.pViewCtrl,
    required LdThemeSectionWidgetState super.pState,
  });

  // GETTERS/SETTERS -----------------
  LdThemeSectionWidgetState get sectionState =>
      super.state as LdThemeSectionWidgetState;

  // Construir el widget
  @override
  Widget buildWidget(BuildContext pCtx) {
    // Aquest mètode no s'utilitza directament perquè la construcció
    // es fa en el mètode build de LdThemeSectionWidget
    return Container();
  }
}
