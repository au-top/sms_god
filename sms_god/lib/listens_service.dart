import 'package:autop_free_flutter_utils/debug_mode_print.dart';
import 'package:flutter_incoming_call/flutter_incoming_call.dart';
import 'package:hive/hive.dart';
import 'package:sms_god/global_define.dart';
import 'package:sms_god/hive_ext.dart';
import 'package:sms_god/main.dart';
import 'package:sms_god/model/app_config.dart';
import 'package:sms_god/sdk/enterprise_wechat_bot.dart';
import 'package:sms_god/sdk/free_message.dart';
import 'package:telephony/telephony.dart';

Future initListensService({required AppConfig appConfig}) async {
  final telephony = Telephony.instance;
  await telephony.requestSmsPermissions;
  await FlutterIncomingCall.configure(
    appName: 'example_incoming_call',
    duration: 30000,
    android: ConfigAndroid(
      vibration: true,
      ringtonePath: 'default',
      channelId: 'calls',
      channelName: 'Calls channel name',
      channelDescription: 'Calls channel description',
    ),
    ios: ConfigIOS(
      iconName: 'AppIcon40x40',
      ringtonePath: null,
      includesCallsInRecents: false,
      supportsVideo: true,
      maximumCallGroups: 2,
      maximumCallsPerCallGroup: 1,
    ),
  );
  FlutterIncomingCall.onEvent.listen((event) {
    debugModePrint(event);
    if (event is CallEvent) {
      debugModePrint(event);
    }
  });

  telephony.listenIncomingSms(
    onNewMessage: (smsMessage) {
      debugModePrint("- onMessage");
      _onMessage(smsMessage, appConfig);
    },
    onBackgroundMessage: onBackgroundMessage,
  );
}

Future onBackgroundMessage(SmsMessage smsMessage) async {
  debugModePrint("- onBackgroundMessage");
  await initHive();
  await Hive.syncBox(ConfigHiveName);
  final data = AppConfig.r();
  _onMessage(smsMessage, data);
}

Future _onMessage(
  SmsMessage smsMessage,
  AppConfig appConfig,
) async {
  debugModePrint(appConfig.freeMessageConfig.passwd);
  await Future.value(
    [
      () async {
        if (appConfig.freeMessageConfig.enable) {
          await FreeMessageAPI(
            targetUUID: appConfig.freeMessageConfig.targetUUID,
            email: appConfig.freeMessageConfig.email,
            passwd: appConfig.freeMessageConfig.passwd,
            cpassword: appConfig.freeMessageConfig.cpassword,
            baseUrl: appConfig.freeMessageConfig.baseUrl,
          ).onMessage(smsMessage);
        }
      },
      () async {
        if (appConfig.weChatSdkConfig.enable) {
          await EnterpriseWeChatBot(
            agentid: appConfig.weChatSdkConfig.agentid,
            corpid: appConfig.weChatSdkConfig.corpid,
            corpsecret: appConfig.weChatSdkConfig.corpsecret,
            url: appConfig.weChatSdkConfig.url,
          ).onMessage(smsMessage);
        }
      }
    ]
        .map((e) => Future(e).catchError((e) async {
              debugModePrint(e);
            }))
        .toList(),
  );
}
