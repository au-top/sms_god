import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sms_god/config.dart';

Future<String> getToken() async {
  final response = await Dio().get(EWB.url, queryParameters: {'corpid': EWB.corpid, 'corpsecret': EWB.corpsecret});
  return response.data["access_token"] as String;
}

Future pushMessage(String touserValue, String pushContent) async {
  final content = {
    "touser": touserValue,
    "msgtype": "text",
    "agentid": EWB.agentid,
    "text": {"content": pushContent},
    "safe": "0"
  };
  await Dio().post("https://qyapi.weixin.qq.com/cgi-bin/message/send?access_token=${await getToken()}", data: jsonEncode(content));
}
