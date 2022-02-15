import 'package:flutter/material.dart';
import 'package:sms_god/sdk/free_message/api_treaty.dart';
import 'package:sms_god/sdk/free_message/less_snack_bar.dart';

/// http 请求调用该函数运行全局判断的逻辑
bool globalHandel(BuildContext? context, HttpPackage httpPackage) {
  switch (httpPackage.code) {
    case ApiStateCode.ok:
      return true;
    default:
      final errorTipsContent = "发生错误Code:${httpPackage.code}. 描述: ${ApiStateCode.getApiStateCodeDescribe(httpPackage.code)}";
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          lessSnackBar(
            context,
            content: DefaultTextStyle.merge(
              child: Text(errorTipsContent),
            ),
            backgroundColor: Colors.white,
          ),
        );
      }

      /// get stack trace
      print("error: $errorTipsContent}");
      print("stacktrace: ${StackTrace.current}");
      return false;
  }
}
