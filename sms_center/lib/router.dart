import 'package:sms_center/controller/helloworld.dart';
import 'package:sms_center/support/router_setuper.dart';

class AppRouter {
  static final start = buildRouter(
    children: {
      "/helloworld": helloworldController,
    },
  );
}
