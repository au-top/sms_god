import 'package:flutter/cupertino.dart';
import 'package:sms_god/sdk/free_message/data/data_mount.dart';

abstract class FutureState<T> {
  late final Future<T> initState;
}

abstract class MountState {
  Widget mount(WidgetBuilder builder);
}

mixin SupportAsyncChangeNotifier on ChangeNotifier {
  Future asyncUpdate() async {
    notifyListeners();
  }
}

abstract class GlobalState<T> with ChangeNotifier, SupportAsyncChangeNotifier implements MountState {
  GlobalKey globalKey = GlobalKey();

  @override
  Widget mount(WidgetBuilder builder) {
    return Builder(key: globalKey, builder: builder);
  }
}

abstract class GlobalFutureState<T> with ChangeNotifier, SupportAsyncChangeNotifier implements FutureState<T>, MountState {
  GlobalKey globalKey = GlobalKey();

  @override
  late final Future<T> initState;

  @override
  Widget mount(WidgetBuilder builder) {
    return FutureDataMount<GlobalFutureState>(
      key: globalKey,
      data: this,
      loadBuilder: (context) => const SizedBox(),
      builder: builder,
    );
  }
}
