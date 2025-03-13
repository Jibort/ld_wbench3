// Widget per a seccions de demostració de tema.
// Created: 2025/03/06 dj.

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ld_wbench3/core/ld_widget.dart';
import 'package:ld_wbench3/core/ld_view_ctrl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// WIDGET 'LdThemeSectionWidget' ======
class LdThemeSectionWidget extends LdWidget<LdThemeSectionWidgetCtrl> {
  // 📝 ESTÀTICS -----------------------
  static const String className = "LdThemeSectionWidget";
  static const String widgetTag = "${className}_tag";

  // 🛠️ CONSTRUCTORS ---------------------
  LdThemeSectionWidget({
    super.key,
    required LdViewCtrl viewCtrl,
    required String pTitle,
    required Widget pChild,
    EdgeInsetsGeometry? pPadding,
    EdgeInsetsGeometry? pMargin,
    String? customTag,
  }) : super(pViewCtrl: viewCtrl) {
    tag = widgetTag;
    typeName = className;
    ctrl = LdThemeSectionWidgetCtrl(
      pTag:
          customTag ??
          "${widgetTag}_${viewCtrl.tag}_${DateTime.now().millisecondsSinceEpoch}",
      pViewCtrl: viewCtrl,
      title: pTitle,
      child: pChild,
      padding: pPadding,
      margin: pMargin,
    );
  }
}

class LdThemeSectionWidgetCtrl extends LdWidgetCtrl {
  // 📝 ESTÀTICS -----------------------
  static const className = "LdThemeSectionWidgetCtrl";

  // 🧩 MEMBRES --------------------------
  GetBuilder<LdThemeSectionWidgetCtrl>? _getBuilder;
  final String title;
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  // CONSTRUCTOR ---------------------
  LdThemeSectionWidgetCtrl({
    required super.pTag,
    required super.pViewCtrl,
    super.pFocusable = true,
    required this.title,
    required this.child,
    this.padding,
    this.margin,
  });

  // 'LdWdiget' -----------------------
  @override
  void rebuildFromScrath() {
    _getBuilder = null;
  }

  @override
  Widget buildWidget(BuildContext pCtx) {
    _getBuilder ??= GetBuilder<LdThemeSectionWidgetCtrl>(
      id: tag,
      tag: tag,
      init: this,
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
    return _getBuilder!;
  }
}
