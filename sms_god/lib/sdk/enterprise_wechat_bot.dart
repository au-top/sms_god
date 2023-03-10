import 'package:get_phone_number/get_phone_number.dart';
import 'package:sms_god/main.dart';
import 'package:sms_god/model/app_config.dart';
import 'package:sms_god/sdk/enterprise_wechat_bot/api.dart';
import 'package:sms_god/sdk/sdk_api.dart';
import 'package:sms_god/state/local/log.dart';
import 'package:telephony/telephony.dart';

class EnterpriseWeChatBot extends SdkApi {
  final String agentid;
  final String corpid;
  final String corpsecret;
  final String url;

  EnterpriseWeChatBot({
    required this.agentid,
    required this.corpid,
    required this.corpsecret,
    required this.url,
  });

  @override
  Future onMessage(SmsMessage message, {required AppConfig appConfig}) async {
    await _sendMessage(message, appConfig);
  }

  Future<void> _sendMessage(SmsMessage message, AppConfig appConfig) async {
    var phoneNumbers = [];
    try {
      phoneNumbers.addAll(await GetPhoneNumber().getListPhoneNumber());
    } catch (e) {
      smsLog.add(LogElem(level: LogElemLevel.serious, content: e.toString(), origin: "[EnterpriseWeChatBot]"));
    }
    await pushMessage(
      "@all",
      [
        if (phoneNumbers.isNotEmpty) "当前手机插入的手机卡号: $phoneNumbers",
        if (appConfig.deviceName.isNotEmpty) "设备名: ${appConfig.deviceName}",
        message.address,
        if (message.date != null) DateTime.fromMillisecondsSinceEpoch(message.date!),
        message.body,
      ].join("\n"),
      agentid: agentid,
      corpid: corpid,
      corpsecret: corpsecret,
      url: url,
    );
  }
}
