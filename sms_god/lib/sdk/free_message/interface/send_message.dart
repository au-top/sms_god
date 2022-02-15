import 'dart:convert';

import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/material.dart';
import 'package:sms_god/sdk/free_message/api_base.dart';
import 'package:sms_god/sdk/free_message/api_treaty.dart';
import 'package:sms_god/sdk/free_message/config.dart';
import 'package:sms_god/sdk/free_message/functions/enum_make.dart';
import 'package:sms_god/sdk/free_message/request_handel.dart';
import 'package:sms_god/sdk/free_message/treaty/chat_message.dart';

class SendMessageData implements ApiModel {
  String content;
  String targetUUID;
  ChatMessageType msgType;

  SendMessageData({required this.content, required this.targetUUID, required this.msgType});

  @override
  Map<String, dynamic> toMap() {
    return {
      "content": content,
      "targetUUID": targetUUID,
      "msgType": chatMessageTypeMap[msgType]!,
    };
  }
}

/// ChatMessage Content Type 的类型定义
enum ChatMessageContentElemType {
  text,
  emotion,
  sound,
  webrtc,
  image,
  none,
}

final chatMessageContentElemTypeMap = makeEnumMap({
  ChatMessageContentElemType.sound: "sound",
  ChatMessageContentElemType.text: "text",
  ChatMessageContentElemType.webrtc: "webrtc",
  ChatMessageContentElemType.emotion: "emotion",
  ChatMessageContentElemType.image: "image",
  ChatMessageContentElemType.none: "none",
}, ChatMessageContentElemType.values);

/// 用于将 单个信息进行包装 类型可以是 [ChatMessageContentElemType] 中的一种
class ChatMessageContentElem {
  late final ChatMessageContentElemType type;
  late final String content;

  ChatMessageContentElem({required this.type, required this.content});

  ChatMessageContentElem.text({required String text}) {
    content = text;
    type = ChatMessageContentElemType.text;
  }

  ChatMessageContentElem.sound({required String soundURL}) {
    content = soundURL;
    type = ChatMessageContentElemType.sound;
  }

  ChatMessageContentElem.image({required String imageURL}) {
    content = imageURL;
    type = ChatMessageContentElemType.image;
  }

  ChatMessageContentElem.fromMap(Map map) {
    type = chatMessageContentElemTypeMap.toEnum(map["type"]) ?? ChatMessageContentElemType.none;
    content = map["content"];
  }

  Map<String, dynamic> toMap() {
    return {"content": content, "type": chatMessageContentElemTypeMap.toValue(type)};
  }

  @override
  String toString() {
    switch (type) {
      case ChatMessageContentElemType.text:
        return content;
      case ChatMessageContentElemType.image:
        return "[Image]";
      case ChatMessageContentElemType.webrtc:
        return "[WebRTC]";
      case ChatMessageContentElemType.emotion:
        return "[Emotion]";
      case ChatMessageContentElemType.sound:
        return "[Sound]";
      case ChatMessageContentElemType.none:
        return "[NoSupperType]";
    }
  }
}

/// [elems] 字段存储  [ChatMessageContentElem] 来表示这条消息的内容
/// ChatMessageContent 提供将 消息封装成最终进行传输的数据的能力
/// 发送消息流程  SourceData(任意[ChatMessageContentElem]可以接受的数据类型)  -> [ChatMessageContentElem] -> [ChatMessageContent] -> (WebSocket)Send
/// 接受消息 recv(String) -> [ChatMessageContent] -> (Widget)[ChatMessageContentView]
class ChatMessageContent {
  final List<ChatMessageContentElem> elems = [];

  ChatMessageContent();

  String toPackageString() {
    final elemMaps = elems.map((e) => e.toMap()).toList();
    return jsonEncode({"elems": elemMaps});
  }

  ChatMessageContent.fromString(String packageString) {
    try {
      final dePackage = jsonDecode(packageString);
      elems.addAll(List.from(dePackage["elems"]).map((e) => ChatMessageContentElem.fromMap(e)));
    } catch (e) {
      print(e);
      elems.add(ChatMessageContentElem(content: "[ 该信息目前版本不支持解析 ]", type: ChatMessageContentElemType.text));
    }
  }

  @override
  String toString() {
    return elems.map((e) => e.toString()).join('');
  }
}

Future<HttpPackage<dynamic>> sendMessage(BuildContext? context, SendMessageData sendMessageData) async {
  final dio = initBaseDio();

  final result = await dio.post("$serverHost/message/send", data: sendMessageData.toMap());
  print(result.requestOptions.headers);
  final _hp = HttpPackage.fromMap(result.data);
  globalHandel(context, _hp);
  return _hp;
}
