// Controlador de la vista 'EmptyView'.
// CreatedAt: 2025/03/11 dt. JIQ

// Controlador de la vista 'EmptyView'.
// CreatedAt: 2025/03/11 dt. JIQ
// Actualitzat: 2025/03/15 ds. - Afegit botó per a la vista WorldTime

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

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
import 'package:ld_wbench3/views/world_time/view.dart';

class EmptyViewCtrl extends LdViewCtrl<EmptyViewCtrl, EmptyViewState> {
  // 📝 ESTÀTICS -----------------------
  static const className = "EmptyViewCtrl";
  static const viewTag = "${className}_tag";
  static const btnToggleIdx = "btnToggle";
  static const btnDummyIdx = "btnDummy";

  // 🧩 MEMBRES ------------------------
  LdActionButtonWidget? btnToggle, btnDummy;
  LdButtonWidget? btnExpand, btnOutlined, btnWorldTime;
  LdEditWidget? edtName;
  LdEditWidget? edtEMail;
  LdEditWidget? edtPassword;
  LdTextAreaWidget? edtTextArea;

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
    btnToggle!.update();
    btnDummy!.isEnabled = !btnDummy!.isEnabled;
    btnDummy!.update();
    LdThemeCtrl.single.toggleTheme();
    btnToggle!.iconData =
        (LdThemeCtrl.single.isDarkMode) ? Icons.light_mode : Icons.dark_mode;
    LdThemeCtrl.single.notify(
      pTgts: [
        scaffoldIdx,
        appBarProgressIdx,
        appBarIdx,
        btnToggleIdx,
        btnDummyIdx,
      ],
    );
  }

  // Navegació a la vista d'hores mundials
  void navigateToWorldTime() {
    Get.toNamed(WorldTimeView.routeName);
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
          iconData:
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
          iconData: Icons.data_exploration,
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
            // Botó per a la vista d'hores mundials
            LdButtonWidget.icon(
              viewCtrl: this,
              text: 'Hora Mundial',
              iconData: Icons.public,
              type: LdButtonType.elevated,
              onPressed: navigateToWorldTime,
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
            edtEMail = LdEditWidget(
              viewCtrl: this,
              label: 'Correu electrònic',
              placeholder: 'exemple@correu.com',
              type: LdEditType.email,
              prefixIcon: Icons.email,
            ),
            VertSep(16.0),
            edtPassword = LdEditWidget(
              viewCtrl: this,
              label: 'Contrasenya',
              placeholder: '********',
              type: LdEditType.password,
              prefixIcon: Icons.lock,
            ),
            VertSep(16.0),
            edtTextArea = LdTextAreaWidget(
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
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import 'package:ld_wbench3/core/ld_view.dart';
// import 'package:ld_wbench3/views/empty/view.dart';
// import 'package:ld_wbench3/widgets/ld_button_widget.dart';
// import 'package:ld_wbench3/widgets/ld_edit_widget.dart';
// import 'package:ld_wbench3/widgets/ld_text_area_widget.dart';
// import 'package:ld_wbench3/widgets/separators.dart';
// import 'package:ld_wbench3/widgets/widget_key.dart';
// import 'package:ld_wbench3/theme/ld_theme_ctrl.dart';
// import 'package:ld_wbench3/widgets/ld_scaffold_widget.dart';
// import 'package:ld_wbench3/widgets/ld_action_button_widget.dart';

// class EmptyViewCtrl extends LdViewCtrl<EmptyViewCtrl, EmptyViewState> {
//   // 📝 ESTÀTICS -----------------------
//   static const className = "EmptyViewCtrl";
//   static const viewTag = "${className}_tag";
//   static const btnToggleIdx = "btnToggle";
//   static const btnDummyIdx = "btnDummy";

//   // 🧩 MEMBRES ------------------------
//   LdActionButtonWidget? btnToggle, btnDummy;
//   LdButtonWidget? btnExpand;
//   LdEditWidget? edtName;
//   LdEditWidget? edtEMail;
//   LdEditWidget? edtPassword;
//   LdTextAreaWidget? edtTextArea;

//   // 🛠️ CONSTRUCTORS ------------------
//   EmptyViewCtrl({required super.pTag, required super.pViewState}) {
//     addWidgets([
//       scaffoldIdx,
//       pageBodyIdx,
//       appBarIdx,
//       appBarProgressIdx,
//       btnToggleIdx,
//       // "btnExpand",
//     ]);
//   }

//   // 📥 GETTERS/SETTERS ----------------
//   EmptyViewState get emptyViewState => super.state as EmptyViewState;

//   // Botons d'acció ------------------
//   void toggleTheme() {
//     btnToggle!.isEnabled = !btnToggle!.isEnabled;
//     btnToggle!.update();
//     btnDummy!.isEnabled = !btnDummy!.isEnabled;
//     btnDummy!.update();
//     LdThemeCtrl.single.toggleTheme();
//     btnToggle!.iconData =
//         (LdThemeCtrl.single.isDarkMode) ? Icons.light_mode : Icons.dark_mode;
//     LdThemeCtrl.single.notify(
//       pTgts: [
//         scaffoldIdx,
//         appBarProgressIdx,
//         appBarIdx,
//         btnToggleIdx,
//         btnDummyIdx,
//       ],
//     );
//   }

//   // 'LdViewCtrl' ---------------------
//   @override
//   Widget buildView(BuildContext pBCtx) {
//     LdScaffoldWidget scaffold = LdScaffoldWidget(
//       pViewCtrl: this,
//       pTitle: state.title,
//       pSubTitle: state.subtitle,
//       actions: [
//         btnToggle = LdActionButtonWidget(
//           enabled: true,
//           focusable: false,
//           pTag: btnToggleIdx,
//           pViewCtrl: this,
//           pViewState: state,
//           onPressed: toggleTheme,
//           iconData:
//               LdThemeCtrl.single.isDarkMode
//                   ? Icons.light_mode
//                   : Icons.dark_mode,
//         ),
//         btnDummy = LdActionButtonWidget(
//           pTag: btnDummyIdx,
//           enabled: false,
//           focusable: false,
//           pViewCtrl: this,
//           pViewState: state,
//           onPressed: toggleTheme,
//           iconData: Icons.data_exploration,
//         ),
//       ],
//       body: SingleChildScrollView(
//         clipBehavior: Clip.antiAlias,
//         padding: EdgeInsets.all(12.0.h),
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 HortSep(20.0),
//                 LdButtonWidget(
//                   icon: Icon(Icons.arrow_back),
//                   viewCtrl: this,
//                   text: "Expansió...",
//                   type: LdButtonType.elevated,
//                   onPressed: () {},
//                 ),
//                 HortSep(20.0),
//                 LdButtonWidget(
//                   viewCtrl: this,
//                   text: 'Outlined',
//                   type: LdButtonType.outlined,
//                   onPressed: () {},
//                 ),
//               ],
//             ),
//             VertSep(16.0),
//             edtName = LdEditWidget(
//               viewCtrl: this,
//               label: 'Nom complet',
//               placeholder: 'Introdueix el teu nom',
//               helperText: 'Escriu el teu nom i cognoms',
//               prefixIcon: Icons.person,
//             ),
//             VertSep(16.0),
//             edtEMail = LdEditWidget(
//               viewCtrl: this,
//               label: 'Correu electrònic',
//               placeholder: 'exemple@correu.com',
//               type: LdEditType.email,
//               prefixIcon: Icons.email,
//             ),
//             VertSep(16.0),
//             edtPassword = LdEditWidget(
//               viewCtrl: this,
//               label: 'Contrasenya',
//               placeholder: '********',
//               type: LdEditType.password,
//               prefixIcon: Icons.lock,
//             ),
//             VertSep(16.0),
//             edtTextArea = LdTextAreaWidget(
//               viewCtrl: this,
//               label: 'Descripció',
//               placeholder: 'Escriu una descripció detallada...',
//               helperText: 'Màxim 500 caràcters',
//               maxLength: 500,
//               showCounter: true,
//             ),
//             VertSep(16.0),
//           ],
//         ),
//       ),
//     );
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       edtName!.requestFocus();
//     });
//     return scaffold;
//   }
// }
