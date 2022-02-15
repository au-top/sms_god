import 'package:flutter/material.dart';
import 'package:sms_god/dialog/showLogElem.dart';
import 'package:sms_god/sdk/enterprise_wechat_bot.dart';
import 'package:sms_god/state/local/log.dart';
import 'package:telephony/telephony.dart';

final smsLog = SMSLog();
void main() {
  runApp(const AppBootstrap());
}

class AppBootstrap extends StatelessWidget {
  const AppBootstrap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Index(),
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
    );
  }
}

class Index extends StatefulWidget {
  const Index({Key? key}) : super(key: key);

  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  final telephony = Telephony.instance;
  @override
  void initState() {
    super.initState();
    Future(() async {
      await telephony.requestSmsPermissions;
      telephony.listenIncomingSms(
        onNewMessage: EnterpriseWeChatBot.onMessage,
        onBackgroundMessage: EnterpriseWeChatBot.onMessageBackground,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          children: [_buildLogButton()],
          mainAxisSize: MainAxisSize.min,
        ),
      ),
    );
  }

  _buildLogButton() {
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return Center(
              child: Padding(
                child: Material(
                  child: LogListView(smsLog: smsLog),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
              ),
            );
          },
        );
      },
      child: const Text("Log"),
    );
  }
}
