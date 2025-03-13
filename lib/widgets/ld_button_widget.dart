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
    bool pEnabled = true,
    bool pFocusable = false,
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
  }) : super(pViewCtrl: viewCtrl, pEnabled: pEnabled, pFocusable: pFocusable) {
    tag = pTag ?? "${widgetTag}_${DateTime.now().millisecondsSinceEpoch}";
    typeName = className;

    ctrl = LdButtonWidgetCtrl(
      pTag: tag,
      pViewCtrl: viewCtrl,
      pEnabled: pEnabled,
      pFocusable: pFocusable,
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
    withHorizontalAnimation(
      animationColor: Colors.blue.withAlpha((0.3 * 255.0).round()),
      animationDuration: Duration(milliseconds: 400),
      btnCtrl: ctrl,
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
  // late AnimationController _animCtrl;
  // late Animation<double> _anim;
  // final Offset _tapPosition = Offset.zero;

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
    super.pEnabled = true,
    super.pFocusable = false,
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

  @override
  void onInit() {
    super.onInit();
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
            return FocusScope(
              canRequestFocus: false,
              child: SizedBox(
                width: width,
                height: height,
                child: ElevatedButton(
                  onPressed: isLoading ? null : onPressed,
                  style: buttonStyle,
                  child: childWidget,
                ),
              ),
            );
          case LdButtonType.outlined:
            return FocusScope(
              canRequestFocus: false,
              child: SizedBox(
                width: width,
                height: height,
                child: OutlinedButton(
                  focusNode:
                      (isFocusable) ? null : FocusNode(canRequestFocus: false),
                  onPressed: isLoading ? null : onPressed,
                  style: buttonStyle,
                  child: childWidget,
                ),
              ),
            );
          case LdButtonType.text:
            return FocusScope(
              canRequestFocus: false,
              child: SizedBox(
                width: width,
                height: height,
                child: TextButton(
                  focusNode:
                      (isFocusable) ? null : FocusNode(canRequestFocus: false),
                  onPressed: isLoading ? null : onPressed,
                  style: buttonStyle,
                  child: childWidget,
                ),
              ),
            );
        }
      },
    );
    // return _getBuilder!;
  }
}

/// Extensió per afegir animació horitzontal a LdButtonWidget
extension LdButtonAnimationExtension on LdButtonWidget {
  Widget withHorizontalAnimation({
    Color animationColor = Colors.white30,
    Duration animationDuration = const Duration(milliseconds: 500),
    required LdButtonWidgetCtrl btnCtrl,
  }) {
    return _LdButtonAnimationWrapper(
      button: this,
      animationColor: animationColor,
      animationDuration: animationDuration,
      btnCtrl: btnCtrl,
    );
  }
}

/// Widget d'embolcall per afegir l'animació
class _LdButtonAnimationWrapper extends StatefulWidget {
  final LdButtonWidget button;
  final Color animationColor;
  final Duration animationDuration;
  final LdButtonWidgetCtrl btnCtrl;

  const _LdButtonAnimationWrapper({
    required this.button,
    required this.animationColor,
    required this.animationDuration,
    required this.btnCtrl,
  });

  @override
  State<_LdButtonAnimationWrapper> createState() =>
      _LdButtonAnimationWrapperState(btnCtrl);
}

class _LdButtonAnimationWrapperState extends State<_LdButtonAnimationWrapper>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  Offset _tapPosition = Offset.zero;
  bool _isAnimating = false;
  LdButtonWidgetCtrl btnCtrl;
  _LdButtonAnimationWrapperState(this.btnCtrl);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _isAnimating = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startAnimation(TapDownDetails details) {
    setState(() {
      _tapPosition = details.localPosition;
      _isAnimating = true;
    });
    _controller.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    // Mantenim l'onPressed original
    final originalOnPressed = btnCtrl.onPressed;

    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          // Boto original amb gestor de clics personalitzat
          GestureDetector(
            onTapDown: _startAnimation,
            // Passem els clics al botó original
            onTap: originalOnPressed,
            child: widget.button,
          ),

          // Capa d'animació només visible durant l'animació
          if (_isAnimating)
            Positioned.fill(
              child: IgnorePointer(
                child: AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return CustomPaint(
                      painter: _HorizontalRipplePainter(
                        color: widget.animationColor,
                        progress: _animation.value,
                        tapPosition: _tapPosition,
                      ),
                      size: Size.infinite,
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// CustomPainter per dibuixar l'animació d'ona horitzontal
class _HorizontalRipplePainter extends CustomPainter {
  final Color color;
  final double progress;
  final Offset tapPosition;

  _HorizontalRipplePainter({
    required this.color,
    required this.progress,
    required this.tapPosition,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint =
        Paint()
          ..color = color.withAlpha((255 * (1.0 - progress)).round())
          ..style = PaintingStyle.fill;

    // Calculem les amplades d'expansió
    final double leftWidth = tapPosition.dx * progress;
    final double rightWidth = (size.width - tapPosition.dx) * progress;

    // Rectangle esquerre
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(tapPosition.dx - leftWidth, 0, leftWidth, size.height),
        Radius.circular(4.0),
      ),
      paint,
    );

    // Rectangle dret
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(tapPosition.dx, 0, rightWidth, size.height),
        Radius.circular(4.0),
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(_HorizontalRipplePainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.color != color ||
        oldDelegate.tapPosition != tapPosition;
  }
}
