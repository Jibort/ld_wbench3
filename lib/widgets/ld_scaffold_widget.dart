// Widget embolcall per al Scaffold de l'aplicació.
// Created: 2025/03/06 dj.

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ld_wbench3/core/ld_widget.dart';
import 'package:ld_wbench3/widgets/ld_app_bar_widget.dart';
import 'package:ld_wbench3/widgets/widget_key.dart';

// WIDGET 'LdScaffoldWidget' ==========
class LdScaffoldWidget extends LdWidget<LdScaffoldWidgetCtrl> {
  // 📝 ESTÀTICS -----------------------
  static const String className = "LdScaffoldWidget";

  // 🧩 MEMBRES --------------------------
  LdAppBarWidget? appBar;
  Widget body;
  List<Widget>? actions;

  // CONSTRUCTOR ---------------------
  LdScaffoldWidget({
    super.key = const Key(scaffoldIdx),
    required super.pViewCtrl,
    required String pTitle,
    String? pSubTitle,
    required this.body,
    this.actions,
    Widget? floatingActionButton,
    Widget? drawer,
    Widget? bottomNavigationBar,
    Color? backgroundColor,
    FloatingActionButtonLocation? floatingActionButtonLocation,
    List<Widget>? persistentFooterButtons,
  }) {
    tag = scaffoldIdx;
    typeName = className;
    ctrl = LdScaffoldWidgetCtrl(
      pTag: scaffoldIdx,
      pViewCtrl: viewCtrl,
      title: pTitle,
      subtitle: pSubTitle,
      actions: actions,
      body: body,
      floatingActionButton: floatingActionButton,
      drawer: drawer,
      bottomNavigationBar: bottomNavigationBar,
      backgroundColor: backgroundColor,
      floatingActionButtonLocation: floatingActionButtonLocation,
      persistentFooterButtons: persistentFooterButtons,
    );
  }
}

// CTRL 'LdScaffoldWidgetCtrl' ========
class LdScaffoldWidgetCtrl extends LdWidgetCtrl {
  // 📝 ESTÀTICS -----------------------
  static const className = "LdScaffoldWidgetCtrl";

  // 🧩 MEMBRES --------------------------
  GetBuilder<LdScaffoldWidgetCtrl>? _getBuilder;
  Key? key;
  Widget? appBar;
  String title;
  String? subtitle;
  final Widget body;
  final List<Widget>? actions;
  final Widget? floatingActionButton;
  final Widget? drawer;
  final Widget? bottomNavigationBar;
  final Color? backgroundColor;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final List<Widget>? persistentFooterButtons;

  // 🛠️ CONSTRUCTORS ------------------
  LdScaffoldWidgetCtrl({
    key,
    required super.pTag,
    required super.pViewCtrl,
    required this.title,
    this.subtitle,
    required this.body,
    this.actions,
    this.floatingActionButton,
    this.drawer,
    this.bottomNavigationBar,
    this.backgroundColor,
    this.floatingActionButtonLocation,
    this.persistentFooterButtons,
  });

  // 'LdWdiget' -----------------------
  @override
  void rebuildFromScrath() {
    _getBuilder = null;
    appBar = null;
  }

  @override
  Widget buildWidget(BuildContext pCtx) {
    appBar ??= LdAppBarWidget(
      viewCtrl: viewCtrl,
      title: title,
      subtitle: subtitle,
      showProgress: viewCtrl.state.isLoading || viewCtrl.state.isLoadingAgain,
      actions: actions,
    );
    _getBuilder ??= GetBuilder<LdScaffoldWidgetCtrl>(
      id: tag,
      tag: tag,
      init: this,
      builder:
          (scaffoldCtrl) => Scaffold(
            key: key ?? const Key(scaffoldIdx),
            appBar: LdAppBarWidget(
              viewCtrl: viewCtrl,
              title: title,
              subtitle: subtitle,
              actions: actions,
            ),
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
