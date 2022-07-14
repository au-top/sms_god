import 'dart:convert';

import 'package:autop_free_dart_utils/custom_base64.dart';
import 'package:dio/dio.dart';
import 'package:autop_free_flutter_utils/debug_mode_print.dart';

class DioEncryption extends Interceptor {
  late final CustomPassword customPassword;
  DioEncryption(this.customPassword);
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.data[0] != null) {
      response.data = jsonDecode(freeAirDecode(response.data, customPassword));
      handler.next(response);
    } else {
      debugModePrint("解密失败发生错误 ${response.requestOptions.uri}");
      assert(false);
    }
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.method == "POST") options.data = [freeAirEncode(jsonEncode(options.data), customPassword)];
    handler.next(options);
  }
}

/// 加密
String freeAirEncode(String rawString, CustomPassword _cPassword) {
  return encodeCustomBase64(rawString, _cPassword);
}

/// 解密
String freeAirDecode(String rawString, CustomPassword _cPassword) {
  return decodeCustomBase64(rawString, _cPassword);
}
