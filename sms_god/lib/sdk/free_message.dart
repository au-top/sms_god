import 'package:autop_free_dart_utils/custom_base64.dart';
import 'package:autop_free_flutter_utils/debug_mode_print.dart';
import 'package:dio/dio.dart';
import 'package:sms_god/sdk/free_message/api_base.dart';
import 'package:sms_god/sdk/free_message/interface/send_message.dart';
import 'package:sms_god/sdk/free_message/interface/signin.dart';
import 'package:sms_god/sdk/free_message/treaty/chat_message.dart';
import 'package:sms_god/sdk/sdk_api.dart';
import 'package:telephony/telephony.dart';

import 'free_message/api_treaty.dart';

class FreeMessageAPI extends SdkApi {
  late final String targetUUID;
  late final String email;
  late final String passwd;
  late final List<String> cpassword;
  late final String baseUrl;
  late final userWithDio = _signInDio();

  FreeMessageAPI({
    required this.targetUUID,
    required this.email,
    required this.passwd,
    required this.cpassword,
    required this.baseUrl,
  });

  @override
  Future onMessage(SmsMessage message) async {
    debugModePrint(["message", message.address, message.body]);
    await _sendMessage(message, "activation");
  }

  Future<Dio> _signInDio() async {
    final dio = initBaseDio(CustomPassword(cpassword));
    await signIn(
      dio,
      SignInApiData(email: email, passwd: passwd, platform: "IOS"),
      serverHost: baseUrl,
    );
    return dio;
  }

  Future _sendMessage(SmsMessage message, String tag) async {
    final dio = await userWithDio;
    final messageBody = ChatMessageContent()
      ..elems.add(
        ChatMessageContentElem.text(
          text: [
            tag,
            message.address,
            message.date,
            message.subject,
            message.subscriptionId,
            message.type?.name,
            message.body,
          ].join("\n"),
        ),
      );
    await sendMessage(
      dio,
      SendMessageData(
        content: messageBody.toPackageString(),
        targetUUID: targetUUID,
        msgType: ChatMessageType.single,
      ),
      serverHost: baseUrl,
    );
  }
}
