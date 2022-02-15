import 'package:flutter/material.dart';
import 'package:sms_god/sdk/free_message/api_base.dart';
import 'package:sms_god/sdk/free_message/api_treaty.dart';
import 'package:sms_god/sdk/free_message/config.dart';
import 'package:sms_god/sdk/free_message/request_handel.dart';

class SignInApiData implements ApiModel {
  String email;
  String passwd;

  SignInApiData({required this.email, required this.passwd});

  @override
  Map<String, dynamic> toMap() {
    return {
      "email": email,
      "passwd": passwd,
    };
  }
}

class SignInApiResult {
  late final String email;
  late final String? uuid;

  SignInApiResult({required this.email, this.uuid});

  SignInApiResult.fromHttpPackage(HttpPackage httpPackage) {
    email = httpPackage.data["email"];
    uuid = httpPackage.data["uuid"];
  }
}

Future<HttpPackage> signIn(BuildContext? context, SignInApiData data) async {
  final dio = initBaseDio();
  final result = await dio.postUri(Uri.parse("$serverHost/user/signin"), data: data.toMap());
  final _hp = HttpPackage.fromMap(result.data);
  globalHandel(context, _hp);
  _hp.printLog("signIn");
  return _hp;
}
