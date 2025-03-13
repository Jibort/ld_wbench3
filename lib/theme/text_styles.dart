import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

TextStyle txsAppBarTitleStyle({Color? pFgColor}) {
  return TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 14.0.h,
    fontStyle: FontStyle.normal,
    color: pFgColor ?? Colors.white,
    fontFamily: 'Roboto',
  );
}

TextStyle txsAppBarSubtitleStyle({Color? pFgColor}) {
  return TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 10.0.h,
    fontStyle: FontStyle.normal,
    color: pFgColor ?? Colors.white70,
    fontFamily: 'Roboto',
  );
}

// Estil per a les etiquetes de camps d'edició
TextStyle txsInputLabelStyle({Color? pFgColor}) {
  return TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 18.0, // Igual que els botons
    fontStyle: FontStyle.normal,
    color: pFgColor,
    fontFamily: 'Roboto',
  );
}

// Estil per al text d'entrada en camps d'edició
TextStyle txsInputTextStyle({Color? pFgColor}) {
  return TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 12.0.h, // Igual que els botons
    fontStyle: FontStyle.normal,
    color: pFgColor,
    fontFamily: 'Roboto',
  );
}

// Estil per al text d'ajuda en camps d'edició
TextStyle? _inputHelperStyle;
TextStyle txsInputHelperStyle({Color? pFgColor}) {
  _inputHelperStyle ??= TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 9.0.h,
    fontStyle: FontStyle.normal,
    color: pFgColor ?? Colors.grey.shade600,
    fontFamily: 'Roboto',
  );

  return _inputHelperStyle!;
}

// Estil per al text d'error en camps d'edició
TextStyle txsInputErrorStyle({Color? pFgColor}) {
  return TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 12.0.h,
    fontStyle: FontStyle.normal,
    color: pFgColor ?? Colors.red,
    fontFamily: 'Roboto',
  );
}
