import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sms_god/sdk/free_message/api_base.dart';
import 'package:sms_god/sdk/free_message/api_treaty.dart';
import 'package:sms_god/sdk/free_message/request_handel.dart';

class SignInApiData implements ApiModel {
  String email;
  String passwd;
  String platform;

  SignInApiData({required this.email, required this.passwd, required this.platform});

  @override
  Map<String, dynamic> toMap() {
    return {"email": email, "passwd": passwd, "platform": platform};
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

Future<HttpPackage> signIn(Dio dio, SignInApiData data, {required String serverHost}) async {
  final result = await dio.postUri(Uri.parse("$serverHost/user/signin"), data: data.toMap());
  return HttpPackage.fromMap(result.data);
}
