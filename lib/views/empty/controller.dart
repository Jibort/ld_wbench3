// Controlador de la vista 'EmptyView'.
// CreatedAt: 2025/03/11 dt. JIQ

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ld_wbench3/core/ld_view.dart';
import 'package:ld_wbench3/views/empty/view.dart';
import 'package:ld_wbench3/widgets/ld_button_widget.dart';
import 'package:ld_wbench3/widgets/ld_edit_widget.dart';
import 'package:ld_wbench3/widgets/ld_text_area_widget.dart';
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
  LdEditWidget? edtName;

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
  Widget buildView(BuildContext pBCtx) {
    LdScaffoldWidget scaffold = LdScaffoldWidget(
      pViewCtrl: this,
      pTitle: state.title,
      pSubTitle: state.subtitle,
      actions: [
        btnToggle = LdActionButtonWidget(
          enabled: true,
          focusable: false,
          pTag: btnToggleIdx,
          pViewCtrl: this,
          pViewState: state,
          onPressed: toggleTheme,
          icon:
              LdThemeCtrl.single.isDarkMode
                  ? Icons.light_mode
                  : Icons.dark_mode,
        ),
        btnDummy = LdActionButtonWidget(
          pTag: btnDummyIdx,
          enabled: false,
          focusable: false,
          pViewCtrl: this,
          pViewState: state,
          onPressed: toggleTheme,
          icon: Icons.data_exploration,
        ),
      ],
      body: SingleChildScrollView(
        clipBehavior: Clip.antiAlias,
        padding: EdgeInsets.all(12.0.h),
        child: Column(
          children: [
            Row(
              children: [
                HortSep(20.0),
                LdButtonWidget(
                  icon: Icon(Icons.arrow_back),
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
            VertSep(16.0),
            edtName = LdEditWidget(
              viewCtrl: this,
              label: 'Nom complet',
              placeholder: 'Introdueix el teu nom',
              helperText: 'Escriu el teu nom i cognoms',
              prefixIcon: Icons.person,
            ),
            VertSep(16.0),
            LdEditWidget(
              viewCtrl: this,
              label: 'Correu electrònic',
              placeholder: 'exemple@correu.com',
              type: LdEditType.email,
              prefixIcon: Icons.email,
            ),
            VertSep(16.0),
            LdEditWidget(
              viewCtrl: this,
              label: 'Contrasenya',
              placeholder: '********',
              type: LdEditType.password,
              prefixIcon: Icons.lock,
            ),
            VertSep(16.0),
            LdTextAreaWidget(
              viewCtrl: this,
              label: 'Descripció',
              placeholder: 'Escriu una descripció detallada...',
              helperText: 'Màxim 500 caràcters',
              maxLength: 500,
              showCounter: true,
            ),
            VertSep(16.0),
          ],
        ),
      ),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      edtName!.requestFocus();
    });
    return scaffold;
  }
}
