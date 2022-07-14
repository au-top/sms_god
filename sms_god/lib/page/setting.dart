import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sms_god/model/app_config.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  late final weChatUrlTEC = TextEditingController(text: context.read<AppConfig>().weChatSdkConfig.url);
  late final weChatCorpsecretTEC = TextEditingController(text: context.read<AppConfig>().weChatSdkConfig.corpsecret);
  late final weChatCorpidTEC = TextEditingController(text: context.read<AppConfig>().weChatSdkConfig.corpid);
  late final weChatAgentidTEC = TextEditingController(text: context.read<AppConfig>().weChatSdkConfig.agentid);

  late final fmEmailTEC = TextEditingController(text: context.read<AppConfig>().freeMessageConfig.email);
  late final fmPasswordTEC = TextEditingController(text: context.read<AppConfig>().freeMessageConfig.passwd);
  late final fmTargetUUIDTEC = TextEditingController(text: context.read<AppConfig>().freeMessageConfig.targetUUID);
  late final fmBaseUrl = TextEditingController(text: context.read<AppConfig>().freeMessageConfig.baseUrl);
  late final fmCpasswordTEC = TextEditingController(text: jsonEncode(context.read<AppConfig>().freeMessageConfig.cpassword));

  late final Function _saveData;

  @override
  void initState() {
    _saveData = context.read<AppConfig>().save;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Setting"),
      ),
      body: ListTileTheme.merge(
        dense: true,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            _buildPrimaryListTile(
              leading: const Icon(Icons.wechat_rounded),
              title: const Text("WeChatBot"),
              primaryColor: Colors.green,
              contentColor: Colors.white,
            ),
            Consumer<AppConfig>(
              builder: (context, appConfig, child) => SwitchListTile(
                title: const Text("启用WeChat"),
                value: appConfig.weChatSdkConfig.enable,
                onChanged: (bool value) {
                  appConfig.weChatSdkConfig.enable = value;
                  appConfig.update();
                },
              ),
            ),
            ListTile(
              title: TextField(
                decoration: const InputDecoration(label: Text("url"), isDense: true),
                controller: weChatUrlTEC,
                onChanged: (value) {
                  context.read<AppConfig>().weChatSdkConfig.url = value;
                },
              ),
            ),
            ListTile(
              title: TextField(
                decoration: const InputDecoration(label: Text("corpsecret")),
                controller: weChatCorpsecretTEC,
                onChanged: (value) {
                  context.read<AppConfig>().weChatSdkConfig.corpsecret = value;
                },
              ),
            ),
            ListTile(
              title: TextField(
                decoration: const InputDecoration(label: Text("corpid")),
                controller: weChatCorpidTEC,
                onChanged: (value) {
                  context.read<AppConfig>().weChatSdkConfig.corpid = value;
                },
              ),
            ),
            ListTile(
              title: TextField(
                decoration: const InputDecoration(label: Text("agentid")),
                controller: weChatAgentidTEC,
                onChanged: (value) {
                  context.read<AppConfig>().weChatSdkConfig.agentid = value;
                },
              ),
            ),
            const SizedBox(height: 40),
            _buildPrimaryListTile(
              leading: const Icon(Icons.link_rounded),
              title: const Text("FreeMessageLink"),
              contentColor: Colors.white,
              primaryColor: Colors.blue,
            ),
            Consumer<AppConfig>(
              builder: (context, appConfig, child) => SwitchListTile(
                title: const Text("启用FreeMessageLink"),
                value: appConfig.freeMessageConfig.enable,
                onChanged: (bool value) {
                  appConfig.freeMessageConfig.enable = value;
                  appConfig.update();
                },
              ),
            ),
            ListTile(
              title: TextField(
                decoration: const InputDecoration(label: Text("email")),
                controller: fmEmailTEC,
                onChanged: (value) {
                  context.read<AppConfig>().freeMessageConfig.email = value;
                },
              ),
            ),
            ListTile(
              title: TextField(
                decoration: const InputDecoration(label: Text("passwd")),
                controller: fmPasswordTEC,
                onChanged: (value) {
                  context.read<AppConfig>().freeMessageConfig.passwd = value;
                },
              ),
            ),
            ListTile(
              title: TextField(
                decoration: const InputDecoration(label: Text("targetUUID")),
                controller: fmTargetUUIDTEC,
                onChanged: (value) {
                  context.read<AppConfig>().freeMessageConfig.targetUUID = value;
                },
              ),
            ),
            ListTile(
              title: TextField(
                decoration: const InputDecoration(label: Text("BaseUrl")),
                controller: fmBaseUrl,
                onChanged: (value) {
                  context.read<AppConfig>().freeMessageConfig.baseUrl = value;
                },
              ),
            ),
            ListTile(
              title: TextField(
                decoration: const InputDecoration(label: Text("cpassword")),
                controller: fmCpasswordTEC,
              ),
              trailing: AnimatedBuilder(
                animation: fmCpasswordTEC,
                builder: (context, child) {
                  bool isJson = false;
                  try {
                    context.read<AppConfig>().freeMessageConfig.cpassword = List<String>.from(jsonDecode(fmCpasswordTEC.text));
                    isJson = true;
                  } catch (_) {}

                  if (isJson) {
                    return const Icon(Icons.done_rounded, color: Colors.green);
                  } else {
                    return const Icon(Icons.close_rounded, color: Colors.red);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _saveData();
    super.dispose();
  }
}

Widget _buildPrimaryListTile({
  required Color primaryColor,
  required Color contentColor,
  required Widget title,
  required Widget leading,
}) {
  return ListTile(
    dense: false,
    leading: leading,
    title: title,
    tileColor: primaryColor,
    textColor: contentColor,
    iconColor: contentColor,
  );
}
