// Separadors bàsics per a l'aplicació Sabina.
// CreatedAt: 2025/03/06 dj. JIQ

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// WIDGET 'VertSep' ===================
class VertSep extends StatelessWidget {
  // MEMBERS --------------------------
  final double sep;

  // CONSTRUCTORS ---------------------
  const VertSep(this.sep, {super.key});

  // 'StatelessWidget' ----------------
  @override
  Widget build(BuildContext context) => SizedBox(height: sep.h);
}

// WIDGET 'HortSep' ===================
class HortSep extends StatelessWidget {
  // MEMBERS --------------------------
  final double sep;

  // CONSTRUCTORS ---------------------
  const HortSep(this.sep, {super.key});

  // 'StatelessWidget' ----------------
  @override
  Widget build(BuildContext context) => SizedBox(width: sep.w);
}
