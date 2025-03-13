import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

TextStyle txsAppBarTitleStyle({Color? pFgColor}) {
  return TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 18.0.h,
    fontStyle: FontStyle.normal,
    color: pFgColor ?? Colors.white,
    fontFamily: 'Roboto',
  );
}

TextStyle txsAppBarSubtitleStyle({Color? pFgColor}) {
  return TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 12.0.h,
    fontStyle: FontStyle.normal,
    color: pFgColor ?? Colors.white70,
    fontFamily: 'Roboto',
  );
}
