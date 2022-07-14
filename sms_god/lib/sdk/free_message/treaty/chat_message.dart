import 'package:autop_free_dart_utils/enum_make.dart';
import 'package:sms_god/sdk/free_message/api_treaty.dart';

enum ChatMessageType { group, single }

final chatMessageTypeMap = makeEnumMap({
  ChatMessageType.group: "group",
  ChatMessageType.single: "single",
}, ChatMessageType.values);

class ChatMessage {
  late final String uuid;

  late final String? groupUUID;
  late final List<String>? singleUUIDAgg;
  late final String? singleRecvUUID;

  late final String sendUserUUID;
  late final ChatMessageType type;
  late final int createDate;
  late final String content;

  ChatMessage.fromHttpPackage(HttpPackage httpPackage) {
    _fromJson(httpPackage.data);
  }

  ChatMessage.fromMap(Map<String, dynamic> rawMap) {
    _fromJson(rawMap);
  }

  _fromJson(Map<String, dynamic> jsondata) {
    uuid = jsondata["uuid"];
    groupUUID = jsondata["groupUUID"];
    singleUUIDAgg = List.castFrom<dynamic, String>(jsondata["singleUUIDAgg"]);
    singleRecvUUID = jsondata["singleRecvUUID"];
    sendUserUUID = jsondata["sendUserUUID"];
    type = chatMessageTypeMap.toEnum(jsondata["type"])!;
    createDate = jsondata["createDate"];
    content = jsondata["content"];
    assert(type != null);
  }
}
