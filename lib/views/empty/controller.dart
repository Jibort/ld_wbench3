// Controlador de la vista 'EmptyView'.
// CreatedAt: 2025/03/11 dt. JIQ

import 'package:flutter/material.dart';

import 'package:ld_wbench3/core/ld_view.dart';
import 'package:ld_wbench3/views/empty/view.dart';
import 'package:ld_wbench3/widgets/ld_button_widget.dart';
import 'package:ld_wbench3/widgets/separators.dart';
import 'package:ld_wbench3/widgets/widget_key.dart';
import 'package:ld_wbench3/theme/ld_theme_ctrl.dart';
import 'package:ld_wbench3/widgets/ld_scaffold_widget.dart';
import 'package:ld_wbench3/widgets/ld_action_button_widget.dart';

class EmptyViewCtrl extends LdViewCtrl<EmptyViewCtrl, EmptyViewState> {
  // 📝 ESTÀTICS -----------------------
  static const className = "EmptyViewCtrl";
  static const viewTag = "${className}_tag";
  static const btnToggleIdx = "btnToggle";
  static const btnDummyIdx = "btnDummy";

  // 🧩 MEMBRES ------------------------
  LdActionButtonWidget? btnToggle, btnDummy;
  LdButtonWidget? btnExpand;

  // 🛠️ CONSTRUCTORS ------------------
  EmptyViewCtrl({required super.pTag, required super.pViewState}) {
    addWidgets([
      scaffoldIdx,
      pageBodyIdx,
      appBarIdx,
      appBarProgressIdx,
      btnToggleIdx,
      // "btnExpand",
    ]);
  }

  // 📥 GETTERS/SETTERS ----------------
  EmptyViewState get emptyViewState => super.state as EmptyViewState;

  // Botons d'acció ------------------
  void toggleTheme() {
    btnToggle!.isEnabled = !btnToggle!.isEnabled;
    btnDummy!.isEnabled = !btnDummy!.isEnabled;
    LdThemeCtrl.single.toggleTheme();
    LdThemeCtrl.single.notify(
      pTgts: [
        scaffoldIdx,
        appBarProgressIdx,
        appBarIdx,
        btnToggleIdx,
        btnDummyIdx,
        // "btnExpand",
      ],
    );
  }

  // 'LdViewCtrl' ---------------------
  @override
  Widget buildView(BuildContext pBCtx) => LdScaffoldWidget(
    pViewCtrl: this,
    pTitle: state.title,
    pSubTitle: state.subtitle,
    actions: [
      btnToggle = LdActionButtonWidget(
        pTag: btnToggleIdx,
        pViewCtrl: this,
        pViewState: state,
        onPressed: toggleTheme,
        icon:
            LdThemeCtrl.single.isDarkMode ? Icons.light_mode : Icons.dark_mode,
      ),
      btnDummy = LdActionButtonWidget(
        pTag: btnDummyIdx,
        enabled: false,
        pViewCtrl: this,
        pViewState: state,
        onPressed: toggleTheme,
        icon: Icons.data_exploration,
      ),
    ],
    body: Center(
      child: Row(
        children: [
          HortSep(20.0),
          LdButtonWidget(
            // pTag: "btnExpand",
            viewCtrl: this,
            text: "Expansió...",
            type: LdButtonType.elevated,
            onPressed: () {},
          ),
          HortSep(20.0),
          LdButtonWidget(
            viewCtrl: this,
            text: 'Outlined',
            type: LdButtonType.outlined,
            onPressed: () {},
          ),
        ],
      ),
    ),
  );
}
