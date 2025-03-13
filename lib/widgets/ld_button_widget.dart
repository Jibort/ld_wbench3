// Widget embolcall per als botons de l'aplicació.
// Created: 2025/03/10 dl. CLA

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ld_wbench3/core/ld_view.dart';
import 'package:ld_wbench3/core/ld_widget.dart';

final _borderRadius = 10.0.r;
final _height = 45.0.h;

// Enumeració per als tipus de botons suportats
enum LdButtonType { elevated, outlined, text }

// WIDGET 'LdButtonWidget' =============
class LdButtonWidget extends LdWidget<LdButtonWidgetCtrl> {
  // 📝 ESTÀTICS -----------------------
  static const String className = "LdButtonWidget";
  static const String widgetTag = "ldButtonWidgetTag";

  // 🛠️ CONSTRUCTORS ---------------------
  LdButtonWidget({
    super.key,
    required LdViewCtrl viewCtrl,
    String? pTag,
    required String text,
    Widget? icon,
    void Function()? onPressed,
    LdButtonType? type,
    Color? backgroundColor,
    Color? foregroundColor,
    double? width,
    double? height,
    double? borderRadius,
    EdgeInsetsGeometry? padding,
    bool isLoading = false,
  }) : super(pViewCtrl: viewCtrl) {
    tag = pTag ?? "${widgetTag}_${DateTime.now().millisecondsSinceEpoch}";
    typeName = className;
    ctrl = LdButtonWidgetCtrl(
      pTag: tag,
      pViewCtrl: viewCtrl,
      onPressed: onPressed,
      text: text,
      type: type ?? LdButtonType.elevated,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      icon: icon,
      width: width,
      height: height,
      borderRadius: borderRadius,
      padding: padding,
    );
  }

  // CONSTRUCTOR AUXILIAR PER BOTÓ AMB ICONA
  factory LdButtonWidget.icon({
    Key? key,
    required LdViewCtrl viewCtrl,
    String? pTag,
    required String text,
    required IconData iconData,
    VoidCallback? onPressed,
    LdButtonType type = LdButtonType.elevated,
    Color? backgroundColor,
    Color? foregroundColor,
    Color? iconColor,
    double? width,
    double? height,
    double? borderRadius,
    EdgeInsetsGeometry? padding,
    bool isLoading = false,
  }) {
    padding ??= EdgeInsets.all(10.0.h);
    borderRadius ??= _borderRadius;
    height ??= height;
    return LdButtonWidget(
      key: key,
      viewCtrl: viewCtrl,
      text: text,
      icon: Icon(iconData, color: iconColor, size: 20.0.sp),
      onPressed: onPressed,
      type: type,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      width: width,
      height: height ?? _height,
      borderRadius: borderRadius,
      padding: padding,
      isLoading: isLoading,
      pTag: pTag,
    );
  }

  // Construeix l'estil del botó
}

// CTRL 'LdButtonWidgetCtrl' ===========
class LdButtonWidgetCtrl extends LdWidgetCtrl {
  // 📝 ESTÀTICS -----------------------
  static const className = "LdButtonWidgetCtrl";

  // 🧩 MEMBRES ------------------------
  final String text;
  final Widget? icon;
  final VoidCallback? onPressed;
  final LdButtonType type;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? width;
  double? height;
  double? borderRadius;
  EdgeInsetsGeometry? padding;
  final bool isLoading;

  // CONSTRUCTOR ---------------------
  LdButtonWidgetCtrl({
    required super.pTag,
    required super.pViewCtrl,
    required this.text,
    this.icon,
    this.onPressed,
    this.type = LdButtonType.elevated,
    this.backgroundColor,
    this.foregroundColor,
    this.width,
    this.height,
    this.borderRadius,
    this.padding,
    this.isLoading = false,
  }) {
    padding ??= EdgeInsets.all(15.0.h);
    borderRadius ??= _borderRadius;
    height ??= _height;
  }

  // 'LdWdiget' -----------------------
  @override
  void rebuildFromScrath() {
    // No hi ha builders a anul·lar.
  }

  ButtonStyle _buildButtonStyle(BuildContext context) {
    final theme = Theme.of(context);
    final brightness = theme.brightness;

    // Colors base segons tipus i tema actual
    Color bgColor;
    Color fgColor;

    switch (type) {
      case LdButtonType.elevated:
        bgColor = backgroundColor ?? theme.colorScheme.primary;
        fgColor = foregroundColor ?? theme.colorScheme.onPrimary;
        break;
      case LdButtonType.outlined:
        bgColor = Colors.transparent;
        fgColor =
            foregroundColor ??
            (brightness == Brightness.dark
                ? Colors.lightBlueAccent
                : theme.colorScheme.primary);
        break;
      case LdButtonType.text:
        bgColor = Colors.transparent;
        fgColor =
            foregroundColor ??
            (brightness == Brightness.dark
                ? Colors.lightBlueAccent
                : theme.colorScheme.primary);
        break;
    }

    // Construim l'estil específic per cada tipus de botó
    switch (type) {
      case LdButtonType.elevated:
        return ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: fgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius!),
          ),
          padding: padding,
          disabledBackgroundColor: theme.disabledColor,
          disabledForegroundColor: theme.colorScheme.onSurface.withAlpha(100),
        );
      case LdButtonType.outlined:
        return OutlinedButton.styleFrom(
          foregroundColor: fgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius!),
          ),
          side: BorderSide(
            color:
                brightness == Brightness.dark
                    ? Colors.lightBlueAccent
                    : theme.colorScheme.primary,
            width: 1.5.w,
          ),
          padding: padding,
        );
      case LdButtonType.text:
        return TextButton.styleFrom(
          foregroundColor: fgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius!),
          ),
          padding: padding,
        );
    }
  }

  // Construeix el contingut del botó (text, icona o ambdós)
  Widget _buildChildWidget(BuildContext context) {
    final Color iconColor = _getIconColor(context);

    if (isLoading) {
      return SizedBox(
        height: 20.0.h,
        width: 20.0.h,
        child: CircularProgressIndicator(
          strokeWidth: 2.0.w,
          color: _getProgressColor(context),
        ),
      );
    }

    if (icon != null) {
      // Obtenim la icona original
      Widget iconWidget = icon!;

      // Si la icona és una Icon, assegurem que tingui el color correcte
      if (icon is Icon) {
        final Icon originalIcon = icon as Icon;
        iconWidget = Icon(
          originalIcon.icon,
          color:
              originalIcon.color ??
              iconColor, // Prioritzem el color específic si existeix
          size: originalIcon.size ?? 20.0.sp,
        );
      }
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [iconWidget, SizedBox(width: 8.0.w), Text(text)],
      );
    } else {
      return Text(text);
    }
  }

  Color _getIconColor(BuildContext context) {
    final theme = Theme.of(context);

    switch (type) {
      case LdButtonType.elevated:
        return foregroundColor ?? theme.colorScheme.onPrimary;
      case LdButtonType.outlined:
      case LdButtonType.text:
        return foregroundColor ??
            (theme.brightness == Brightness.dark
                ? Colors.lightBlueAccent
                : theme.colorScheme.primary);
    }
  }

  // Determina el color del CircularProgressIndicator
  Color _getProgressColor(BuildContext context) {
    final theme = Theme.of(context);

    switch (type) {
      case LdButtonType.elevated:
        return theme.colorScheme.onPrimary;
      case LdButtonType.outlined:
      case LdButtonType.text:
        return theme.brightness == Brightness.dark
            ? Colors.lightBlueAccent
            : theme.colorScheme.primary;
    }
  }

  @override
  Widget buildWidget(BuildContext pBCtx) {
    return GetBuilder<LdButtonWidgetCtrl>(
      id: tag,
      tag: tag,
      init: this,
      builder: (buttonCtrl) {
        // Definició dels estils segons el tipus de botó
        final ButtonStyle buttonStyle = _buildButtonStyle(pBCtx);

        // Widget fill que es mostrarà al botó
        Widget childWidget = _buildChildWidget(pBCtx);

        // Crear el botó segons el tipus
        switch (type) {
          case LdButtonType.elevated:
            return SizedBox(
              width: width,
              height: height ?? 40.0.h,
              child: ElevatedButton(
                onPressed: isLoading ? null : onPressed,
                style: buttonStyle,
                child: childWidget,
              ),
            );
          case LdButtonType.outlined:
            return SizedBox(
              width: width,
              height: height ?? 40.0.h,
              child: OutlinedButton(
                onPressed: isLoading ? null : onPressed,
                style: buttonStyle,
                child: childWidget,
              ),
            );
          case LdButtonType.text:
            return SizedBox(
              width: width,
              height: height ?? 40.0.h,
              child: TextButton(
                onPressed: isLoading ? null : onPressed,
                style: buttonStyle,
                child: childWidget,
              ),
            );
        }
      },
    );
    // return _getBuilder!;
  }
}
