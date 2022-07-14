import 'package:flutter/material.dart';

SnackBar lessSnackBar(BuildContext context, {required Widget content, required Color backgroundColor}) {
  return SnackBar(
    width: 500,
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    content: content,
    backgroundColor: backgroundColor,
  );
}
