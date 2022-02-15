import 'package:flutter/material.dart';
import 'package:path/path.dart';

void showSnackBarBig(
  BuildContext context, {
  required Widget child,
  required Color backgroundColor,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: child,
      padding: EdgeInsets.zero,
      backgroundColor: backgroundColor,
    ),
  );
}

void showSnackBarMini(
  BuildContext context, {
  required Widget child,
  required Color backgroundColor,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(milliseconds: 1000),
      elevation: 2,
      width: 100,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      content: FittedBox(
        child: child,
        fit: BoxFit.scaleDown,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      backgroundColor: backgroundColor,
    ),
  );
}
