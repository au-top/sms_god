import 'package:sms_god/sdk/enterprise_wechat_bot/api.dart';
import 'package:telephony/telephony.dart';

abstract class EnterpriseWeChatBot {
  static onMessage(SmsMessage message) async {
    pushMessage(
      "@all",
      [
        message.address,
        if (message.date != null) DateTime.fromMillisecondsSinceEpoch(message.date!),
        message.body,
      ].join("\n"),
    );
  }

  static onMessageBackground(SmsMessage message) async {
    pushMessage(
      "@all",
      [
        message.address,
        if (message.date != null) DateTime.fromMillisecondsSinceEpoch(message.date!),
        message.body,
      ].join("\n"),
    );
  }
}
