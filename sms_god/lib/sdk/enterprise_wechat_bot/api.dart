import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:sms_god/model/app_config.dart';

Future<String> getToken({
  required String url,
  required String corpid,
  required String corpsecret,
}) async {
  final response = await Dio().get(url, queryParameters: {'corpid': corpid, 'corpsecret': corpsecret});
  return response.data["access_token"] as String;
}

Future pushMessage(
  String toUserValue,
  String pushContent, {
  required String agentid,
  required String url,
  required String corpid,
  required String corpsecret,
}) async {
  final content = {
    "touser": toUserValue,
    "msgtype": "text",
    "agentid": agentid,
    "text": {"content": pushContent},
    "safe": "0"
  };
  await Dio().post(
    "https://qyapi.weixin.qq.com/cgi-bin/message/send?access_token=${await getToken(
      url: url,
      corpid: corpid,
      corpsecret: corpsecret,
    )}",
    data: jsonEncode(content),
  );
}
