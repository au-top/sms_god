import 'package:autop_free_dart_utils/custom_base64.dart';
import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:sms_god/sdk/free_message/interceptor/encryption.dart';

class HttpTreatyError extends Error {
  String msg;
  Object httpResult;
  HttpTreatyError({required this.msg, required this.httpResult});
}

/// 用于请求主要后端服务器的DIO对象
Dio initBaseDio(CustomPassword customPassword) {
  final dio = Dio(BaseOptions(
    sendTimeout: 1000 * 10,
    connectTimeout: 1000 * 10,
    receiveTimeout: 1000 * 10,
  ))
    ..interceptors.add(DioEncryption(customPassword))
    ..interceptors.add(CookieManager(CookieJar()))
    ..interceptors.add(
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
  return dio;
}

abstract class ApiModel {
  Map<String, dynamic> toMap();
}
