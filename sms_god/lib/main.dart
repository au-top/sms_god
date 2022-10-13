import 'package:autop_free_flutter_utils/debug_mode_print.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:sms_god/global_define.dart';
import 'package:sms_god/listens_service.dart';
import 'package:sms_god/model/app_config.dart';
import 'package:sms_god/page/setting.dart';
import 'package:sms_god/state/local/log.dart';

final smsLog = SMSLog();

bool _initHive = false;
Future initHive() async {
  if (_initHive) {
    debugModePrint("re init hive");
    return;
  }
  _initHive = true;
  Hive.init("/data/data/top.autopc.sms_god/");
  Hive.registerAdapter(AppConfigAdapter());
  Hive.registerAdapter(WeChatSdkConfigAdapter());
  Hive.registerAdapter(FreeMessageConfigAdapter());
  await Hive.openBox(ConfigHiveName);
}

void main() async {
  await initHive();
  runApp(ChangeNotifierProvider(
    create: (_) => AppConfig.r(),
    child: const AppBootstrap(),
  ));
}

class AppBootstrap extends StatefulWidget {
  const AppBootstrap({super.key});

  @override
  State<AppBootstrap> createState() => _AppBootstrapState();
}

class _AppBootstrapState extends State<AppBootstrap> {
  @override
  void initState() {
    super.initState();
    initListensService(appConfig: context.read<AppConfig>());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "SMSGOD",
      home: const Index(),
      theme: ThemeData.light().copyWith(
        inputDecorationTheme: const InputDecorationTheme(isDense: true),
        appBarTheme: const AppBarTheme(elevation: 0),
      ),
      builder: (context, child) {
        return child!;
      },
    );
  }
}

class Index extends StatefulWidget {
  const Index({Key? key}) : super(key: key);

  @override
  IndexState createState() => IndexState();
}

class IndexState extends State<Index> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).push(CupertinoPageRoute(builder: (_) => const Setting())),
            icon: const Icon(Icons.settings),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: const Center(
        child: Text("SMS"),
      ),
    );
  }
}
