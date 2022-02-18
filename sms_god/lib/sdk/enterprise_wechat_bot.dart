import 'package:get_phone_number/get_phone_number.dart';
import 'package:sms_god/main.dart';
import 'package:sms_god/sdk/enterprise_wechat_bot/api.dart';
import 'package:sms_god/state/local/log.dart';
import 'package:telephony/telephony.dart';

abstract class EnterpriseWeChatBot {
  static onMessage(SmsMessage message) async {
    var phoneNumbers = [];
    try {
      phoneNumbers.addAll(await GetPhoneNumber().getListPhoneNumber());
    } catch (e) {
      smsLog.add(LogElem(level: LogElemLevel.serious, content: e.toString(), origin: "[EnterpriseWeChatBot]"));
    }
    pushMessage(
      "@all",
      [
        "当前手机插入的手机卡号: $phoneNumbers",
        message.address,
        if (message.date != null) DateTime.fromMillisecondsSinceEpoch(message.date!),
        message.body,
      ].join("\n"),
    );
  }

  static onMessageBackground(SmsMessage message) async {
    var phoneNumbers = [];
    try {
      phoneNumbers.addAll(await GetPhoneNumber().getListPhoneNumber());
    } catch (e) {
      smsLog.add(LogElem(level: LogElemLevel.serious, content: e.toString(), origin: "[EnterpriseWeChatBot]"));
    }
    pushMessage(
      "@all",
      [
        "当前手机插入的手机卡号: $phoneNumbers",
        message.address,
        if (message.date != null) DateTime.fromMillisecondsSinceEpoch(message.date!),
        message.body,
      ].join("\n"),
    );
  }
}
