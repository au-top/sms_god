import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

class HttpTreatyError extends Error {
  String msg;
  Object httpResult;
  HttpTreatyError({required this.msg, required this.httpResult});
}

/// 用于请求主要后端服务器的DIO对象
Dio? baseDio;
CookieManager? baseCookieManage;
Dio initBaseDio() {
  if (baseDio == null) {
    baseDio = Dio(BaseOptions(
      sendTimeout: 1000 * 10,
      connectTimeout: 1000 * 10,
      receiveTimeout: 1000 * 10,
    ));
    baseCookieManage = CookieManager(CookieJar());
    baseDio?.interceptors.add(baseCookieManage!);
    baseDio?.interceptors.add(
      InterceptorsWrapper(
        onResponse: (e, handler) {
          if (e.statusCode != null && e.statusCode! >= 400 && e.statusCode! <= 599) {
            throw HttpTreatyError(msg: 'StateCode is Error Code', httpResult: e);
          } else {
            handler.next(e);
          }
        },
      ),
    );
  }
  return baseDio!;
}

/// 去除了 COOKIE 功能的DIO请求对象
/// 主要用于请求 FreeShare 服务器
Dio? freeShareDio;
Dio initFreeShareDio() {
  if (freeShareDio == null) {
    freeShareDio = Dio(BaseOptions(
      sendTimeout: 1000 * 50,
      connectTimeout: 1000 * 30,
      receiveTimeout: 1000 * 50,
    ));
    freeShareDio?.interceptors.add(
      InterceptorsWrapper(
        onResponse: (e, handler) {
          if (e.statusCode != null && e.statusCode! >= 400 && e.statusCode! <= 599) {
            throw HttpTreatyError(msg: 'StateCode is Error Code', httpResult: e);
          } else {
            handler.next(e);
          }
        },
      ),
    );
  }
  return freeShareDio!;
}

abstract class ApiModel {
  Map<String, dynamic> toMap();
}
