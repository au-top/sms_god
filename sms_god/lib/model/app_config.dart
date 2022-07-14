import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:sms_god/global_define.dart';
part 'app_config.g.dart';

@HiveType(typeId: 1)
class AppConfig with ChangeNotifier {
  @HiveField(1)
  final WeChatSdkConfig weChatSdkConfig;

  @HiveField(2)
  final FreeMessageConfig freeMessageConfig;

  AppConfig({required this.weChatSdkConfig, required this.freeMessageConfig});

  factory AppConfig.r() {
    return Hive.box(ConfigHiveName).get(ConfigHiveSaveKey) as AppConfig? ??
        AppConfig(
          weChatSdkConfig: WeChatSdkConfig(
            url: "",
            corpid: "",
            corpsecret: "",
            agentid: "",
            enable: false,
          ),
          freeMessageConfig: FreeMessageConfig(
            email: '',
            passwd: '',
            targetUUID: '',
            cpassword: ["0"],
            baseUrl: '',
            enable: false,
          ),
        );
  }

  update() {
    notifyListeners();
  }

  void save() async {
    final configHive = Hive.box(ConfigHiveName);
    await configHive.put(ConfigHiveSaveKey, this);
    await configHive.flush();
  }
}

@HiveType(typeId: 2)
class WeChatSdkConfig {
  @HiveField(1, defaultValue: '')
  String url;
  @HiveField(2, defaultValue: '')
  String corpid;
  @HiveField(3, defaultValue: '')
  String corpsecret;
  @HiveField(4, defaultValue: '')
  String agentid;
  @HiveField(5, defaultValue: false)
  bool enable;

  WeChatSdkConfig({
    required this.url,
    required this.corpid,
    required this.corpsecret,
    required this.agentid,
    required this.enable,
  });
}

@HiveType(typeId: 3)
class FreeMessageConfig {
  @HiveField(1, defaultValue: '')
  String targetUUID;
  @HiveField(2, defaultValue: '')
  String email;
  @HiveField(3, defaultValue: '')
  String passwd;
  @HiveField(4, defaultValue: ["0"])
  List<String> cpassword;
  @HiveField(5, defaultValue: false)
  bool enable;
  @HiveField(6, defaultValue: '')
  String baseUrl;

  FreeMessageConfig({
    required this.targetUUID,
    required this.cpassword,
    required this.email,
    required this.passwd,
    required this.enable,
    required this.baseUrl,
  });
}
