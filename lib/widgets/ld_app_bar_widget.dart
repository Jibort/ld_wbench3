// Widget embolcall per a l'AppBar de l'aplicació.
// Actualitzat: 2025/03/10 dl. CLA[JIQ]

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ld_wbench3/core/ld_view.dart';
import 'package:ld_wbench3/core/ld_widget.dart';
import 'package:ld_wbench3/tools/null_mang.dart';
import 'package:ld_wbench3/widgets/widget_key.dart';
import 'package:ld_wbench3/theme/text_styles.dart';
import 'package:ld_wbench3/trans/tr.dart';
import 'package:ld_wbench3/tools/consts/ui.dart';
import 'package:ld_wbench3/core/ld_state.dart';

TextScaler _txtScaler = MediaQuery.of(Get.context!).textScaler;

// WIDGET 'LdAppBarWidget' ============
class LdAppBarWidget extends LdWidget<LdAppBarWidgetCtrl>
    implements PreferredSizeWidget {
  // 📝 ESTÀTICS -----------------------
  static const String className = "LdAppBarWidget";
  static const String widgetTag = appBarIdx;

  // 🧩 MEMBRES ------------------------
  final String title;
  final String? subtitle;
  final List<Widget>? actions;
  final bool showProgress;
  final double? progress;
  final bool automaticallyImplyLeading;
  final Widget? leading;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final bool showDrawerIcon;
  final bool showBackButton;
  final double actionsRightMargin;
  final double actionButtonsSpacing;

  // CONSTRUCTOR ---------------------
  LdAppBarWidget({
    Key? key,
    required LdViewCtrl viewCtrl,
    required this.title,
    this.subtitle,
    this.actions,
    this.showProgress = false,
    this.progress,
    this.automaticallyImplyLeading = true,
    this.leading,
    this.backgroundColor,
    this.foregroundColor,
    bool enabled = true,
    bool focusable = false,
    this.showDrawerIcon = false,
    this.showBackButton = false,
    double? pActionsRightMargin,
    double? pActionButtonsSpacing,
  }) : actionsRightMargin = pActionsRightMargin ?? defActionsRightMargin,
       actionButtonsSpacing = pActionButtonsSpacing ?? defActionButtonsSpacing,
       super(key: key ?? const Key(appBarIdx), pViewCtrl: viewCtrl) {
    tag = widgetTag;
    typeName = className;
    ctrl = LdAppBarWidgetCtrl(
      pTag: tag,
      pViewCtrl: viewCtrl,
      pTitle: title,
      pSubtitle: subtitle,
      pShowProgress: showProgress,
      pProgress: progress,
      pEnabled: enabled,
      pFocusable: focusable,
      pShowDrawerIcon: showDrawerIcon,
      pShowBackButton: showBackButton,
      pActions: actions,
      pActionsRightMargin: actionsRightMargin,
      pActionButtonsSpacing: actionButtonsSpacing,
    );
  }

  @override
  Size get preferredSize {
    return Size.fromHeight(kToolbarHeight + _txtScaler.scale(10.0.sp));
  }
}

// CTRL 'LdAppBarWidgetCtrl' ==============
class LdAppBarWidgetCtrl extends LdWidgetCtrl {
  // 📝 STATICS ------------------------
  static const className = "LdAppBarWidgetCtrl";

  // 🧩 MEMBRES --------------------------
  GetBuilder<LdWidgetCtrl>? _progressBuilder;

  final String title;
  final String? subtitle;
  final List<Widget>? actions;
  final bool showProgress;
  final double? progress;
  final bool showDrawerIcon;
  final bool showBackButton;
  final double actionsRightMargin;
  final double actionButtonsSpacing;

  // 🛠️ CONSTRUCTORS ---------------------
  LdAppBarWidgetCtrl({
    required super.pTag,
    required super.pViewCtrl,
    required String pTitle,
    String? pSubtitle,
    bool pShowProgress = false,
    double? pProgress,
    bool pShowDrawerIcon = false,
    bool pShowBackButton = false,
    super.pEnabled = true,
    super.pFocusable = false,
    List<Widget>? pActions,
    required double pActionsRightMargin,
    required double pActionButtonsSpacing,
  }) : title = pTitle,
       subtitle = pSubtitle,
       showProgress = pShowProgress,
       progress = pProgress,
       showDrawerIcon = pShowDrawerIcon,
       showBackButton = pShowBackButton,
       actions = pActions,
       actionsRightMargin = pActionsRightMargin,
       actionButtonsSpacing = pActionButtonsSpacing;

  // Construeix l'icona "leading" en funció de la configuració
  Widget? buildLeadingIcon(BuildContext context) {
    if (showBackButton) {
      return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => Navigator.of(context).pop(),
      );
    } else if (showDrawerIcon) {
      return IconButton(
        icon: Icon(Icons.menu),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      );
    }
    return null;
  }

  // Construeix la barra de progrés per l'estat de càrrega
  Widget buildProgressContent(BuildContext context) {
    _progressBuilder ??= GetBuilder<LdAppBarWidgetCtrl>(
      id: appBarProgressIdx,
      tag: appBarProgressIdx,
      init: this,
      builder: (ctrl) {
        var stats = viewCtrl.state.stats;
        String? loadingElement = Get.parameters[LdState.loadingElm];
        if (loadingElement != null) {
          Get.parameters.remove(LdState.loadingElm);
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "${Tr.loading.tr} ${(loadingElement != null) ? '\'$loadingElement\'' : '...'}",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(
              (stats.$3 != null)
                  ? "${stats.$2} ${Tr.of.tr} ${stats.$1} (${(stats.$3! * 100).toStringAsPrecision(3)}%)"
                  : "${stats.$2} ${Tr.of.tr} ${stats.$1}",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: viewCtrl.state.isError ? Colors.red : null,
              ),
            ),
            LinearProgressIndicator(
              minHeight: 5.0.h,
              value: stats.$3,
              backgroundColor: Theme.of(context).colorScheme.primary,
              valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ],
        );
      },
    );

    return _progressBuilder!;
  }

  // Construeix el contingut normal de l'AppBar quan no està carregant
  Widget buildNormalContent(BuildContext context) {
    return _progressBuilder ??= GetBuilder<LdAppBarWidgetCtrl>(
      id: appBarProgressIdx,
      tag: appBarProgressIdx,
      init: this,
      builder:
          (ctrl) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: txsAppBarTitleStyle()),
              if (subtitle != null)
                Text(
                  subtitle!,
                  style: txsAppBarSubtitleStyle(
                    pFgColor: viewCtrl.state.isError ? Colors.red : null,
                  ),
                  textHeightBehavior: TextHeightBehavior(
                    applyHeightToFirstAscent: true,
                    applyHeightToLastDescent: true,
                  ),
                ),
            ],
          ),
    );
  }

  // 'LdWdiget' -----------------------
  @override
  void rebuildFromScrath() {}

  @override
  Widget buildWidget(BuildContext pBCtx) {
    return GetBuilder<LdAppBarWidgetCtrl>(
      id: appBarIdx,
      tag: appBarIdx,
      init: this,
      builder: (appBarCtrl) {
        final theme = Theme.of(pBCtx);
        // Preparem accions amb espais entre elles i marge a la dreta si n'hi ha
        List<Widget>? spacedActions;
        if (actions != null && actions!.isNotEmpty) {
          spacedActions = [];
          // Afegim cada acció seguida d'un espai
          for (int i = 0; i < actions!.length; i++) {
            // Afegim l'acció
            spacedActions.add(actions![i]);
            // Si no és l'última, afegim un espai
            if (i < actions!.length - 1) {
              spacedActions.add(SizedBox(width: actionButtonsSpacing.w));
            }
          }
          // Afegim el marge a la dreta
          spacedActions.add(SizedBox(width: actionsRightMargin.w));
        }

        return AppBar(
          titleSpacing: 15.0.h,
          automaticallyImplyLeading: true,
          leading: buildLeadingIcon(pBCtx),
          backgroundColor:
              theme.brightness == Brightness.dark
                  ? Colors.blueGrey[800] // Color fosc per al tema fosc
                  : theme.colorScheme.primary,
          foregroundColor: theme.colorScheme.onPrimary,
          title:
              (showProgress)
                  ? buildProgressContent(pBCtx)
                  : buildNormalContent(pBCtx),
          actions: [...?spacedActions],
          bottom:
              showProgress && isNotNull(progress)
                  ? PreferredSize(
                    preferredSize: const Size.fromHeight(2.0),
                    child: LinearProgressIndicator(value: progress),
                  )
                  : null,
        );
      },
    );
    // return _getBuilder!;
  }
}
