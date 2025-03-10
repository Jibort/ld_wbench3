// Widget embolcall per al Scaffold de l'aplicació.
// Created: 2025/03/06 dj.

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ld_wbench3/core/ld_widget.dart';
import 'package:ld_wbench3/widgets/widget_key.dart';

// WIDGET 'LdScaffoldWidget' ==========
class LdScaffoldWidget extends LdWidget<LdScaffoldWidgetCtrl> {
  // 📝 ESTÀTICS -----------------------
  static const String className = "LdScaffoldWidget";
  static const String widgetTag = "ldScaffoldWidgetTag";

  // MEMBRES --------------------------
  GetBuilder<LdScaffoldWidgetCtrl>? _getBuilder;
  final Widget? appBar;
  final Widget body;
  final Widget? floatingActionButton;
  final Widget? drawer;
  final Widget? bottomNavigationBar;
  final Color? backgroundColor;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final List<Widget>? persistentFooterButtons;

  // CONSTRUCTOR ---------------------
  LdScaffoldWidget({
    super.key = const Key(scaffoldIdx),
    this.appBar,
    required this.body,
    this.floatingActionButton,
    this.drawer,
    this.bottomNavigationBar,
    this.backgroundColor,
    this.floatingActionButtonLocation,
    this.persistentFooterButtons,
    required super.pViewCtrl,
  }) {
    tag = widgetTag;
    typeName = className;
    ctrl = LdScaffoldWidgetCtrl(pTag: widgetTag, pViewCtrl: viewCtrl);
  }

  @override
  Widget build(BuildContext pBCtx) {
    _getBuilder ??= GetBuilder<LdScaffoldWidgetCtrl>(
      id: ctrl.tag,
      tag: ctrl.tag,
      builder:
          (scaffoldCtrl) => Scaffold(
            key: key ?? const Key(scaffoldIdx),
            appBar: appBar as PreferredSizeWidget?,
            body: body,
            floatingActionButton: floatingActionButton,
            drawer: drawer,
            bottomNavigationBar: bottomNavigationBar,
            backgroundColor: backgroundColor,
            floatingActionButtonLocation: floatingActionButtonLocation,
            persistentFooterButtons: persistentFooterButtons,
          ),
    );
    return _getBuilder!;
  }
}

// CTRL 'LdScaffoldWidgetCtrl' ========
class LdScaffoldWidgetCtrl extends LdWidgetCtrl {
  // 📝 ESTÀTICS -----------------------
  static const className = "LdScaffoldWidgetCtrl";

  // CONSTRUCTOR ---------------------
  LdScaffoldWidgetCtrl({required super.pTag, required super.pViewCtrl});

  // Construir el widget
  @override
  Widget buildWidget(BuildContext pCtx) {
    // Aquest mètode no s'utilitza directament perquè la construcció
    // es fa en el mètode build de LdScaffoldWidget
    return Container();
  }
}
