// Components per a la vista de test de temes.
// Created: 2025/03/06 dj.

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ld_wbench3/core/ld_widget.dart';
import 'package:ld_wbench3/theme/ld_theme_ctrl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ld_wbench3/views/theme_test/controller.dart';
import 'package:ld_wbench3/widgets/ld_button_widget.dart';
import 'package:ld_wbench3/widgets/ld_card_widget.dart';
import 'package:ld_wbench3/widgets/ld_theme_section_widget.dart';
import 'package:ld_wbench3/widgets/separators.dart';

// WIDGET 'ThemeTestComponents' =======
class ThemeTestComponents extends LdWidget<ThemeTestComponentsCtrl> {
  // 📝 ESTÀTICS -----------------------
  static const String className = "ThemeTestComponents";
  static const String widgetTag = "${className}_tag";

  // CONSTRUCTOR ---------------------
  ThemeTestComponents({super.key, required ThemeTestViewCtrl viewCtrl})
    : super(pViewCtrl: viewCtrl) {
    tag = widgetTag;
    typeName = className;
    ctrl = ThemeTestComponentsCtrl(
      pTag: widgetTag,
      pViewCtrl: viewCtrl,
      pFocusable: true,
    );
  }
}

// CTRL 'ThemeTestComponentsCtrl' =====
class ThemeTestComponentsCtrl extends LdWidgetCtrl {
  // 📝 ESTÀTICS -----------------------
  static const className = "ThemeTestComponentsCtrl";
  static const ctrlTag = "${className}_ctrl";

  // 🧩 MEMBRES --------------------------
  bool showAllComponents = true;
  bool isThemeSwitching = false;

  // CONSTRUCTOR ---------------------
  ThemeTestComponentsCtrl({
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
  Widget buildWidget(BuildContext pBCtx) {
    bool isDarkMode = LdThemeCtrl.single.isDarkMode;
    final theme = Theme.of(pBCtx);
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildThemeSwitchSection(),
          VertSep(24.0),
          _buildColorShowcase(isDarkMode, theme),
          VertSep(24.0),
          _buildButtonsShowcase(theme),
          VertSep(24.0),
          _buildInputsShowcase(theme),
          VertSep(24.0),
          _buildCardsShowcase(theme),
          VertSep(24.0),
          _buildProgressIndicatorsShowcase(theme),
        ],
      ),
    );
  }

  Widget _buildThemeSwitchSection() {
    return LdThemeSectionWidget(
      viewCtrl: viewCtrl,
      pTitle: 'Configuració del tema',
      customTag: '${LdThemeSectionWidget.widgetTag}_config',
      pChild: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildThemeButton(
            'Tema clar',
            Icons.light_mode,
            LdThemeCtrl.single.themeMode == ThemeMode.light,
            () =>
                (viewCtrl as ThemeTestViewCtrl)
                    .setLightTheme(), // viewCtrl.callMethod('setLightTheme'),
          ),
          _buildThemeButton(
            'Tema fosc',
            Icons.dark_mode,
            LdThemeCtrl.single.themeMode == ThemeMode.dark,
            () =>
                (viewCtrl as ThemeTestViewCtrl)
                    .setDarkTheme(), // viewCtrl.callMethod('setDarkTheme'),
          ),
          _buildThemeButton(
            'Tema sistema',
            Icons.settings_suggest,
            LdThemeCtrl.single.themeMode == ThemeMode.system,
            () =>
                (viewCtrl as ThemeTestViewCtrl)
                    .setSystemTheme(), // viewCtrl.callMethod('setSystemTheme'),
          ),
        ],
      ),
    );
  }

  Widget _buildThemeButton(
    String label,
    IconData icon,
    bool isActive,
    VoidCallback onPressed,
  ) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: EdgeInsets.all(16.0.w),
            backgroundColor:
                isActive ? Theme.of(Get.context!).colorScheme.primary : null,
          ),
          child: Icon(icon, size: 24.0.w),
        ),
        VertSep(8.0),
        Text(
          label,
          style: TextStyle(
            fontSize: 12.0.sp,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildColorShowcase(bool isDarkMode, ThemeData theme) {
    return LdThemeSectionWidget(
      viewCtrl: viewCtrl,
      customTag: '${LdThemeSectionWidget.widgetTag}_colors',
      pTitle: 'Colors del tema',
      pChild: Wrap(
        spacing: 8.0.w,
        runSpacing: 8.0.h,
        children: [
          _buildColorItem('Primary', theme.colorScheme.primary),
          _buildColorItem('Secondary', theme.colorScheme.secondary),
          _buildColorItem('Error', theme.colorScheme.error),
          _buildColorItem('Background', theme.scaffoldBackgroundColor),
          _buildColorItem('Surface', theme.colorScheme.surface),
          _buildColorItem('onPrimary', theme.colorScheme.onPrimary),
          _buildColorItem('onSecondary', theme.colorScheme.onSecondary),
        ],
      ),
    );
  }

  Widget _buildColorItem(String name, Color color) {
    final textColor =
        color.computeLuminance() > 0.5 ? Colors.black : Colors.white;

    return Container(
      width: 85.0.w,
      height: 85.0.w,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.0.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            name,
            style: TextStyle(
              color: textColor,
              fontSize: 12.0.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          VertSep(4.0),
          Text(
            '#${color.toARGB32().toRadixString(16).substring(2).toUpperCase()}',
            style: TextStyle(color: textColor, fontSize: 10.0.sp),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonsShowcase(ThemeData theme) {
    return LdThemeSectionWidget(
      viewCtrl: viewCtrl,
      customTag: '${LdThemeSectionWidget.widgetTag}_buttons',
      pTitle: 'Botons',
      pChild: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              LdButtonWidget(
                viewCtrl: viewCtrl,
                text: 'Elevated',
                type: LdButtonType.elevated,
                onPressed: () {},
              ),
              // Botó outline
              LdButtonWidget(
                viewCtrl: viewCtrl,
                text: 'Outlined',
                type: LdButtonType.outlined,
                onPressed: () {},
              ),
              // Botó text
              LdButtonWidget(
                viewCtrl: viewCtrl,
                text: 'Text',
                type: LdButtonType.text,
                onPressed: () {},
              ),
            ],
          ),
          VertSep(16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              LdButtonWidget.icon(
                viewCtrl: viewCtrl,
                text: 'Elevated',
                type: LdButtonType.elevated,
                onPressed: () {},
                iconData: Icons.elevator_outlined,
              ),
              // Botó outline
              LdButtonWidget.icon(
                viewCtrl: viewCtrl,
                text: 'Outlined',
                type: LdButtonType.outlined,
                onPressed: () {},
                iconData: Icons.outlined_flag_sharp,
              ),
              // Botó text
              LdButtonWidget.icon(
                viewCtrl: viewCtrl,
                text: 'Text',
                type: LdButtonType.text,
                onPressed: () {},
                iconData: Icons.text_fields_rounded,
              ),
              // ElevatedButton.icon(
              //   onPressed: () {},
              //   icon: Icon(Icons.save),
              //   label: Text('Desar'),
              // ),
              // OutlinedButton.icon(
              //   onPressed: () {},
              //   icon: Icon(
              //     Icons.delete,
              //     color:
              //         Theme.of(Get.context!).brightness == Brightness.dark
              //             ? Colors
              //                 .lightBlueAccent // Color més clar per tema fosc
              //             : Colors.blue, // Color normal per tema clar
              //   ),
              //   label: Text('Eliminar'),
              // ),
              // IconButton(onPressed: () {}, icon: Icon(Icons.favorite)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInputsShowcase(ThemeData theme) {
    return LdThemeSectionWidget(
      viewCtrl: viewCtrl,
      customTag: '${LdThemeSectionWidget.widgetTag}_inputs',
      pTitle: 'Entrades de text i controls',
      pChild: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: 'TextField',
              hintText: 'Introdueix text',
              prefixIcon: Icon(Icons.person),
            ),
          ),
          VertSep(16.0),
          Row(
            children: [
              Checkbox(value: true, onChanged: (_) {}),
              Text('Checkbox activat'),
              SizedBox(width: 16.0.w),
              Checkbox(value: false, onChanged: (_) {}),
              Text('Checkbox desactivat'),
            ],
          ),
          VertSep(8.0),
          Row(
            children: [
              Switch(value: true, onChanged: (_) {}),
              Text('Switch activat'),
              SizedBox(width: 16.0.w),
              Switch(value: false, onChanged: (_) {}),
              Text('Switch desactivat'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCardsShowcase(ThemeData theme) {
    return LdThemeSectionWidget(
      viewCtrl: viewCtrl,
      customTag: '${LdThemeSectionWidget.widgetTag}_cards',
      pTitle: 'Targetes',
      pChild: Column(
        children: [
          LdCardWidget(
            viewCtrl: viewCtrl,
            elevation: 4,
            child: Padding(
              padding: EdgeInsets.all(16.0.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Targeta estàndard',
                    style: TextStyle(
                      fontSize: 16.0.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  VertSep(8.0),
                  Text(
                    'Aquest és el contingut d\'una targeta amb elevació estàndard.',
                  ),
                ],
              ),
            ),
          ),
          VertSep(16.0),
          LdCardWidget(
            viewCtrl: viewCtrl,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0.r),
              side: BorderSide(
                color: theme.colorScheme.primary.withValues(alpha: 0.5),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Targeta amb vora',
                  style: TextStyle(
                    fontSize: 16.0.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                VertSep(8.0),
                Text(
                  'Aquest és el contingut d\'una targeta amb vora i sense elevació.',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressIndicatorsShowcase(ThemeData theme) {
    return LdThemeSectionWidget(
      viewCtrl: viewCtrl,
      customTag: '${LdThemeSectionWidget.widgetTag}_progress',
      pTitle: 'Indicadors de progrés',
      pChild: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              CircularProgressIndicator(),
              VertSep(8.0),
              Text('Circular'),
            ],
          ),
          Column(
            children: [
              SizedBox(width: 100.0.w, child: LinearProgressIndicator()),
              VertSep(8.0),
              Text('Lineal'),
            ],
          ),
          Column(
            children: [
              SizedBox(
                width: 100.0.w,
                child: LinearProgressIndicator(value: 0.7),
              ),
              VertSep(8.0),
              Text('Determinat (70%)'),
            ],
          ),
        ],
      ),
    );
  }

  // Accions sobre els components.
  void toggleShowAllComponents() {
    showAllComponents = !showAllComponents;
    viewCtrl.notify(pTgts: [tag]);
  }

  // Estat per mostrar animació durant el canvi de tema
  void setThemeSwitching(bool pSwitching) {
    isThemeSwitching = pSwitching;
    viewCtrl.notify(pTgts: [tag]);
  }
}
