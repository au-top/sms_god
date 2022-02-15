import 'package:sms_god/sdk/free_message/interface/send_message.dart';
import 'package:sms_god/sdk/free_message/interface/signin.dart';
import 'package:sms_god/sdk/free_message/treaty/chat_message.dart';
import 'package:telephony/telephony.dart';

final loginFuture = signIn(null, SignInApiData(email: "1535634705@qq.com", passwd: "Aa123456"));
const targetUUID = "useruuidEmail-41152982153780093-1639578768567-1";

abstract class FreeMessageAPI {
  static onMessage(SmsMessage message) async {
    print(["message", message.address, message.body]);
    await loginFuture;
    final messageBody = ChatMessageContent()
      ..elems.add(
        ChatMessageContentElem.text(
          text: [
            "message",
            message.address,
            message.date,
            message.subject,
            message.subscriptionId,
            message.type!.name,
            message.body,
          ].join("\n"),
        ),
      );
    await sendMessage(
      null,
      SendMessageData(
        content: messageBody.toPackageString(),
        targetUUID: targetUUID,
        msgType: ChatMessageType.single,
      ),
    );
  }

  static onMessageBackground(SmsMessage message) async {
    print(["background", message.address, message.body]);
    final messageBody = ChatMessageContent()
      ..elems.add(
        ChatMessageContentElem.text(
          text: [
            "background",
            message.address,
            message.date,
            message.subject,
            message.subscriptionId,
            message.type?.name,
            message.body,
          ].join("\n"),
        ),
      );
    await loginFuture;
    await sendMessage(
      null,
      SendMessageData(
        content: messageBody.toPackageString(),
        targetUUID: targetUUID,
        msgType: ChatMessageType.single,
      ),
    );
  }
}
