import 'package:flutter/material.dart';
import 'package:sms_god/sdk/free_message/functions/media_query.dart';

SnackBar lessSnackBar(BuildContext context, {required Widget content, required Color backgroundColor}) {
  return SnackBar(
    width: (getMediaSize(context).width * .7).clamp(100, 850),
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    content: content,
    backgroundColor: backgroundColor,
  );
}
