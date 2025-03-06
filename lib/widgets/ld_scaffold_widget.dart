// Widget embolcall per al Scaffold de l'aplicació.
// Created: 2025/03/06 dj.

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ld_wbench3/core/ld_view_ctrl.dart';
import 'package:ld_wbench3/core/ld_widget.dart';
import 'package:ld_wbench3/widgets/widget_key.dart';

// WIDGET 'LdScaffoldWidget' ==========
class LdScaffoldWidget
    extends LdWidget<LdScaffoldWidgetState, LdScaffoldWidgetCtrl> {
  // ESTÀTICS -------------------------
  static const String className = "LdScaffoldWidget";
  static const String widgetTag = "ldScaffoldWidgetTag";

  // MEMBRES --------------------------
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
    required LdViewCtrl viewCtrl,
    this.appBar,
    required this.body,
    this.floatingActionButton,
    this.drawer,
    this.bottomNavigationBar,
    this.backgroundColor,
    this.floatingActionButtonLocation,
    this.persistentFooterButtons,
  }) : super(
         pViewCtrl: viewCtrl,
         pState: LdScaffoldWidgetState(
           pLabel: "Scaffold Widget",
           pViewState: viewCtrl.state,
           pViewCtrl: viewCtrl,
         ),
       ) {
    ctrl = LdScaffoldWidgetCtrl(
      pTag: widgetTag,
      pViewCtrl: viewCtrl,
      pState: state,
    );
  }

  @override
  Widget build(BuildContext pCtx) {
    return GetBuilder<LdScaffoldWidgetCtrl>(
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
  }
}

// STATE 'LdScaffoldWidgetState' ======
class LdScaffoldWidgetState extends LdWidgetState {
  // ESTÀTICS -------------------------
  static const className = "LdScaffoldWidgetState";

  // CONSTRUCTOR ---------------------
  LdScaffoldWidgetState({
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

// CTRL 'LdScaffoldWidgetCtrl' ========
class LdScaffoldWidgetCtrl extends LdWidgetCtrl {
  // ESTÀTICS -------------------------
  static const className = "LdScaffoldWidgetCtrl";

  // CONSTRUCTOR ---------------------
  LdScaffoldWidgetCtrl({
    required super.pTag,
    required super.pViewCtrl,
    required LdScaffoldWidgetState super.pState,
  });

  // GETTERS/SETTERS -----------------
  LdScaffoldWidgetState get scaffoldState =>
      super.state as LdScaffoldWidgetState;

  // Construir el widget
  @override
  Widget buildWidget(BuildContext pCtx) {
    // Aquest mètode no s'utilitza directament perquè la construcció
    // es fa en el mètode build de LdScaffoldWidget
    return Container();
  }
}
