// Widget embolcall per a l'AppBar de l'aplicació.
// Created: 2025/03/06 dj.

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ld_wbench3/core/ld_view.dart';
import 'package:ld_wbench3/core/ld_widget.dart';
import 'package:ld_wbench3/widgets/widget_key.dart';
import 'package:ld_wbench3/theme/text_styles.dart';

// WIDGET 'LdAppBarWidget' ============
class LdAppBarWidget extends LdWidget<LdAppBarWidgetCtrl>
    implements PreferredSizeWidget {
  // 📝 ESTÀTICS -----------------------
  static const String className = "LdAppBarWidget";
  static const String widgetTag = "ldAppBarWidgetTag";

  // 🧩 MEMBRES ------------------------
  GetBuilder<LdAppBarWidgetCtrl>? _getBuilder;
  final String title;
  final String? subtitle;
  final List<Widget>? actions;
  final bool showProgress;
  final double progress;
  final bool automaticallyImplyLeading;
  final Widget? leading;
  final Color? backgroundColor;
  final Color? foregroundColor;

  // CONSTRUCTOR ---------------------
  LdAppBarWidget({
    Key? key,
    required LdViewCtrl viewCtrl,
    required this.title,
    this.subtitle,
    this.actions,
    this.showProgress = false,
    this.progress = 0.0,
    this.automaticallyImplyLeading = true,
    this.leading,
    this.backgroundColor,
    this.foregroundColor,
  }) : super(key: key ?? const Key(appBarIdx), pViewCtrl: viewCtrl) {
    tag = widgetTag;
    typeName = className;
    ctrl = LdAppBarWidgetCtrl(pTag: widgetTag, pViewCtrl: viewCtrl);
  }

  @override
  Widget build(BuildContext pBCtx) {
    final theme = Theme.of(pBCtx);
    _getBuilder ??= GetBuilder<LdAppBarWidgetCtrl>(
      id: ctrl.tag,
      tag: ctrl.tag,
      builder:
          (appBarCtrl) => AppBar(
            automaticallyImplyLeading: automaticallyImplyLeading,
            leading: leading,
            backgroundColor:
                backgroundColor ?? theme.appBarTheme.backgroundColor,
            foregroundColor:
                foregroundColor ?? theme.appBarTheme.foregroundColor,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: txsAppBarTitleStyle()),
                if (subtitle != null)
                  Text(subtitle!, style: txsAppBarSubtitleStyle()),
              ],
            ),
            actions: actions,
            bottom:
                showProgress
                    ? PreferredSize(
                      preferredSize: const Size.fromHeight(2.0),
                      child: LinearProgressIndicator(
                        value: progress > 0 ? progress : null,
                      ),
                    )
                    : null,
          ),
    );
    return _getBuilder!;
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

// CTRL 'LdAppBarWidget' ==============
class LdAppBarWidgetCtrl extends LdWidgetCtrl {
  // 📝 STATICS ------------------------
  static const className = "LdAppBarWidgetCtrl";

  // 🛠️ CONSTRUCTORS ---------------------
  LdAppBarWidgetCtrl({required super.pTag, required super.pViewCtrl});

  // 📥 GETTERS/SETTERS ----------------

  // 🔄 'LdWidgetCtrl' -----------------
  @override
  Widget buildWidget(BuildContext pCtx) {
    // Aquest mètode no s'utilitza directament perquè la construcció
    // es fa en el mètode build de LdAppBarWidget
    return Container();
  }
}
